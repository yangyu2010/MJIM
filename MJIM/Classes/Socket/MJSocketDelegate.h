//
//  MJSocketDelegate.h
//  LimitChat
//
//  Created by Yang Yu on 2018/8/3.
//  Copyright © 2018 Musjoy. All rights reserved.
//  Socket 代理

#import <Foundation/Foundation.h>

/// Socket的状态
typedef enum : NSUInteger {
    MJSocketStatusUnConnected = 1000,       /// 未连接
    MJSocketStatusConnecting = 1001,        /// 正在连接
    MJSocketStatusConnected = 1002,         /// 已连接
    MJSocketStatusUnknow = 1003,            /// 未知
} MJSocketStatus;


@protocol MJSocketDelegate;

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
