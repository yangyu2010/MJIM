//
//  MJWebSocketMgr.m
//  MJIM
//
//  Created by Yang Yu on 2018/8/29.
//

#import "MJWebSocketMgr.h"
#import "MJWebSocket.h"
#import <MJWebService/MJWebService.h>

@interface MJWebSocketMgr () <MJSocketDelegate>

/// Socket
@property (nonatomic, strong) MJWebSocket *socket;
/// 当前ip地址
@property (nonatomic, copy) NSString *ipString;
/// 当前重新连接的次数
@property (nonatomic, assign) NSInteger currentConnectCount;

@end

@implementation MJWebSocketMgr

#pragma mark- 单例

static MJWebSocketMgr *_manager = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[MJWebSocketMgr alloc] init];
    });
    return _manager;
}


#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticReachabilityChange:) name:kNoticReachabilityChange object:nil];
        _currentConnectCount = 0;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- Public

/// 初始化配置
- (void)configWithIpString:(NSString *)ipString {
    
    self.ipString = ipString;
    
    /// 初始化SRWebSocket
    self.socket = [[MJWebSocket alloc] initWithIpString:ipString];
    self.socket.delegate = self;
}

/// 开始连接
- (void)startConnect {
    if (self.socket) {
        [self.socket startConnect];
    } else {
        [self configWithIpString:self.ipString];
        [self.socket startConnect];
    }
}

/// 手动停止连接
- (void)stopConnect {
    if (self.socket) {
        [self.socket endConnect];
        self.socket = nil;
    }    
}

/// 发送消息
- (void)sendData:(id)data {
    if (self.socket) {
        [self.socket sendData:data];
    }
}

#pragma mark- Private

/// 监听网络变化
- (void)noticReachabilityChange:(NSNotification *)noti {
    NSInteger status = [noti.object integerValue];
    if (status <= 0) {
        /// MJReachabilityStatusUnknown          = -1,
        /// MJReachabilityStatusNotReachable     = 0,
        /// MJReachabilityStatusReachableViaWWAN = 1,
        /// MJReachabilityStatusReachableViaWiFi = 2,
        [self actionConnectInterruption];
    } else {
        if (self.socket.status != MJSocketStatusConnected ||
            self.socket.status != MJSocketStatusConnecting) {
            _currentConnectCount = 0;
            [self reConnect];
        }
    }
}

/// 连接成功
- (void)actionConnectSucceed {
    _currentConnectCount = 0;
}

/// 连接失败或中断等问题
- (void)actionConnectInterruption {
    [self reConnect];
}


/// 重新连接
- (void)reConnect {
    
    if ([MJWebService reachableState] == MJReachabilityStatusUnknown ||
        [MJWebService reachableState] == MJReachabilityStatusNotReachable) {
        return ;
    }
    
    if (self.socket == nil) {
        return ;
    }
    
    if (self.socket.status == MJSocketStatusConnecting) {
        return ;
    }
    
    if (_currentConnectCount >= SOCKET_RE_CONNECT_MAX_COUNT) {
        _currentConnectCount = 0;
        return ;
    }
    
    _currentConnectCount ++;
    
    self.socket = nil;
    self.socket.delegate = nil;
    
    [self configWithIpString:self.ipString];
    [self startConnect];
    
    //    _isInConnecting = YES;
    NSLog(@"开始重连...");
}


#pragma mark- MJSocketDelegate

/// 接收到消息
- (void)socket:(id<MJSocket>)socket didReceiveMessage:(id)message {
    
    /// 规定服务器给的message都是String类型
    if([message isKindOfClass:[NSString class]] == NO) {
        return ;
    }
    
    /// 服务器消息给的都是字符串，自己需要转成字典
    NSData *JSONData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageBody = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];

    /// 不是字典直接返回
    if ([messageBody isKindOfClass:[NSDictionary class]] == NO) {
        return ;
    }
    
    /// 如果代理需要自己处理所有的消息, 通知, 然后不进行后续的方法
    if (self.handler && [self.handler respondsToSelector:@selector(handleAllMessage:)]) {
        [self.handler handleAllMessage:messageBody];
        return ;
    }
    
    /// 取出和服务器规定的消息类型Type
    NSInteger type = [messageBody[@"type"] integerValue];
    
    if (type == kSocketHeartBeatCode) {
        /// 心跳包
        if (self.handler && [self.handler respondsToSelector:@selector(handlePingMessage)]) {
            [self.handler handlePingMessage];
        }
    }
    else if (type == kSocketLoginCode) {
        /// 登陆后socket成功后, 绑定用户
        if (self.handler && [self.handler respondsToSelector:@selector(handleLoginMessage:)]) {
            [self.handler handleLoginMessage:messageBody];
        }
    }
    else if (type == kSocketReceiveMessageCode) {
        /// 收到正常的消息
        if (self.handler && [self.handler respondsToSelector:@selector(handleReceiveNormalMessage:)]) {
            [self.handler handleReceiveNormalMessage:messageBody];
        }
    }
}

/// 连接成功
- (void)socketDidOpen:(id<MJSocket>)socket {
    [self actionConnectSucceed];
}

/// 连接失败
- (void)socket:(id<MJSocket>)socket didFailWithError:(NSError *)error {
    [self actionConnectInterruption];
    
}

/// 连接断开
- (void)socket:(id<MJSocket>)socket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self actionConnectInterruption];
}


@end
