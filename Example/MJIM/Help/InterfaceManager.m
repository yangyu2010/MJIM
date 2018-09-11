//
//  InterfaceManager.m
//  LimitChat
//
//  Created by Yang Yu on 2018/5/22.
//  Copyright © 2018 Musjoy. All rights reserved.
//

#import "InterfaceManager.h"
#import <WebInterface.h>

@implementation InterfaceManager

/// 授权请求
+ (void)startAuthRequest:(NSString *)action
                describe:(NSString *)describe
                    body:(NSDictionary *)body
              completion:(ActionCompleteBlock)completion {
    
    
    NSDictionary *authDict = @{
                               @"Authorization": @"eyJ0eXAiOiJKV1QiLCJhbGciOiJTSEEyNTYifQ.eyJ1c2VySWQiOjEwMDIsIm5pY2tOYW1lIjoiaVBob25lIHjmtYvor5XmnLoiLCJleHAiOjE1NjgxOTQ0OTN9.D9G2dkL5Za6xowWYxla7TGc_0B0k_SHA5cOFokMYMlc",
                               };
    
    [self startRequest:action describe:describe body:body header:authDict completion:completion];
    
}

/// 普通请求 未授权
+ (void)startRequest:(NSString *)action
            describe:(NSString *)describe
                body:(NSDictionary *)body
              header:(NSDictionary *)header
          completion:(ActionCompleteBlock)completion {
    
    [WebInterface startRequest:action
                      describe:locString([@"API_" stringByAppendingString:describe])
                        header:header
                          body:body
                    completion:^(BOOL isSucceed, NSString *message, id data) {
                        
                        completion? completion(isSucceed, message, data) : 0;
    }];
    
}




@end

