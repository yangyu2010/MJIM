//
//  MJWebSocket.m
//  MJIM
//
//  Created by Yang Yu on 2018/8/29.
//

#import "MJWebSocket.h"
#import <SRWebSocket.h>

@interface MJWebSocket () <SRWebSocketDelegate>

/// webSocket
@property (nonatomic, strong) SRWebSocket *webSocket;

@end

@implementation MJWebSocket

#pragma mark- Init

- (instancetype)initWithIpString:(NSString *)ipString {
    self = [super init];
    if (self) {
        /// 初始化SRWebSocket
        self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:ipString]];
        self.webSocket.delegate = self;
        
        _status = MJSocketStatusUnConnected;
    }
    return self;
}


#pragma mark- Public
/// 开始连接
- (void)startConnect {
    if (self.webSocket == nil) {
        NSLog(@"startConnect webSocket = nil");
        return ;
    }
    
    if (_status == MJSocketStatusConnecting ||
        _status == MJSocketStatusConnected) {
        NSLog(@"startConnect _isInConnecting Connected");
        return ;
    }
    
    if (self.webSocket.readyState == SR_OPEN) {
        /// 已连接
        return ;
    }
    
    NSLog(@"开始连接");
    
    _status = MJSocketStatusConnecting;
    
    [self.webSocket open];
}

/// 手动停止连接
- (void)endConnect {
    if (self.webSocket == nil) {
        NSLog(@"endConnect webSocket = nil");
        return ;
    }
    
    [self.webSocket close];
    self.webSocket = nil;
    _status = MJSocketStatusUnConnected;
}

/// 发送消息
- (void)sendData:(id)data {
    if (self.webSocket.readyState != SR_OPEN) {
        NSLog(@"sendData发送失败 webSocket 未连接❌❌❌");
        return ;
    }
    
    [self.webSocket send:data];
}

- (void)sendPing:(NSData *)ping {
    if (self.webSocket.readyState != SR_OPEN) {
        NSLog(@"sendPing发送失败 webSocket 未连接❌❌❌");
        return ;
    }
    
    [self.webSocket sendPing:ping];
}


#pragma mark- Private

/// 连接成功
- (void)actionConnectSucceed {
    NSLog(@"连接成功 ‼️‼️‼️");
    
    _status = MJSocketStatusConnected;
}

/// 连接失败或中断等问题
- (void)actionConnectInterruption {
    NSLog(@"连接失败 ❌❌❌❌❌");
    
    _status = MJSocketStatusUnConnected;
}




#pragma mark- SRWebSocketDelegate

/// 接收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    if (self.delegate && [self.delegate respondsToSelector:@selector(socket:didReceiveMessage:)]) {
        [self.delegate socket:self didReceiveMessage:message];
    }
}

/// 连接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    
    [self actionConnectSucceed];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(socketDidOpen:)]) {
        [self.delegate socketDidOpen:self];
    }
}

/// 连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
    [self actionConnectInterruption];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(socket:didFailWithError:)]) {
        [self.delegate socket:self didFailWithError:error];
    }
}

/// 连接断开
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
    [self actionConnectInterruption];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(socket:didCloseWithCode:reason:wasClean:)]) {
        [self.delegate socket:self didCloseWithCode:code reason:reason wasClean:wasClean];
    }
}


@end
