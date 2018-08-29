//
//  MJWebSocketMgr.h
//  MJIM
//
//  Created by Yang Yu on 2018/8/29.
//  WebSocket 管理类, 外面使用这个类处理逻辑

#import <Foundation/Foundation.h>
#import "MJSocketDelegate.h"

/// 最大重连次数
#ifndef SOCKET_RE_CONNECT_MAX_COUNT
#define SOCKET_RE_CONNECT_MAX_COUNT   3
#endif

/// 心跳包Type
#ifndef kSocketHeartBeatCode
#define kSocketHeartBeatCode         000000
#endif

/// 登陆Type
#ifndef kSocketLoginCode
#define kSocketLoginCode             000001
#endif

/// 登陆Type
#ifndef kSocketReceiveMessageCode
#define kSocketReceiveMessageCode    000002
#endif



@interface MJWebSocketMgr : NSObject

@property (nonatomic, weak) id <MJSocketMessageHandle> handler;

/// 单例
+ (instancetype)sharedInstance;

/// 初始化配置
- (void)configWithIpString:(NSString *)ipString;

/// 开始连接
- (void)startConnect;

/// 手动停止连接
- (void)stopConnect;

/// 发送消息
- (void)sendData:(id)data;

@end





