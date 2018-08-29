//
//  MJWebSocket.h
//  MJIM
//
//  Created by Yang Yu on 2018/8/29.
//  WebSocket, 请使用 MJWebSocketMgr

#import <Foundation/Foundation.h>
#import "MJSocketDelegate.h"

@interface MJWebSocket : NSObject <MJSocket>

@property (nonatomic, assign) id<MJSocketDelegate> delegate;
@property (nonatomic, assign, readonly) MJSocketStatus status;

/// 初始化
- (instancetype)initWithIpString:(NSString *)ipString;

@end
