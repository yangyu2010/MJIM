//
//  MJSocketDelegate.h
//  LimitChat
//
//  Created by Yang Yu on 2018/8/3.
//  Copyright © 2018 Musjoy. All rights reserved.
//  Socket 代理

#import <Foundation/Foundation.h>
@protocol MJSocketDelegate;

/// Socket的状态
typedef enum : NSUInteger {
    MJSocketStatusUnConnected = 1000,       /// 未连接
    MJSocketStatusConnecting = 1001,        /// 正在连接
    MJSocketStatusConnected = 1002,         /// 已连接
    MJSocketStatusUnknow = 1003,            /// 未知
} MJSocketStatus;


/// Socket协议, Socket实例需实现下面的方法和属性
@protocol MJSocket <NSObject>

/// 开始连接
- (void)startConnect;
/// 手动停止连接
- (void)endConnect;
/// 发送消息
- (void)sendData:(id)data;

@property (nonatomic, weak) id<MJSocketDelegate> delegate;
@property (nonatomic, assign, readonly) MJSocketStatus status;

@end



/// WebSocket的代理, 处理Socket连接, 断开, 收到消息等
@protocol MJSocketDelegate <NSObject>

@required
/// 接收到消息
- (void)socket:(id<MJSocket>)socket didReceiveMessage:(id)message;

@optional
/// 连接成功
- (void)socketDidOpen:(id<MJSocket>)socket;
/// 连接失败
- (void)socket:(id<MJSocket>)socket didFailWithError:(NSError *)error;
/// 连接断开
- (void)socket:(id<MJSocket>)socket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;

@end



/// 收到Socket消息后, 通知外界来处理消息
@protocol MJSocketMessageHandle <NSObject>

@optional
/// 代理自己处理所有的消息, 然后下面三个都不需要了
- (void)handleAllMessage:(NSDictionary *)messageBody;

/// Ping消息处理
- (void)handlePingMessage;
/// 登录消息
- (void)handleLoginMessage:(NSDictionary *)messageBody;
/// 收到普通的消息处理
- (void)handleReceiveNormalMessage:(NSDictionary *)messageBody;

@end


