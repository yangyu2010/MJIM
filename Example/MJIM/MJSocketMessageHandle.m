//
//  MJSocketMessageHandle.m
//  MJIM_Example
//
//  Created by Yang Yu on 2018/8/29.
//  Copyright © 2018 yangyu2010@aliyun.com. All rights reserved.
//

#import "MJSocketMessageHandle.h"
#import <MJWebSocketMgr.h>

@implementation MJSocketMessageHandle

/// 代理自己处理所有的消息, 然后下面三个都不需要了
- (void)handleAllMessage:(NSDictionary *)messageBody {
    
    NSLog(@"_handleAllMessage: %@", messageBody);
    
    /// 取出和服务器规定的消息类型Type
    NSInteger type = [messageBody[@"type"] integerValue];
    
    if (type == kSocketHeartBeatCode) {
        /// 心跳包
        NSDictionary *dict = @{
                               @"type": [NSString stringWithFormat:@"%d", kSocketHeartBeatCode],
                               };
        
        NSData *data= [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString *strPing = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        [[MJWebSocketMgr sharedInstance] sendData:strPing];
    }
}

@end
