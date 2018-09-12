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
                               @"Authorization": @"eyJ0eXAiOiJKV1QiLCJhbGciOiJTSEEyNTYifQ.eyJ1c2VySWQiOjEwODcsIm5pY2tOYW1lIjoidGhlODg4IiwiZXhwIjoxNTY4MjU0MTYyfQ.alz4q5sAeMfMROLNP0Wp6BFQ9gGp-AvAh3jlN8ZFTtY",
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

