//
//  MJDBHelp.h
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/11.
//  数据库操作

#import <Foundation/Foundation.h>

@interface MJDBHelp : NSObject



/**
 初始化数据库, 在didFinishLaunchingWithOptions里调用
 如果你使用的不是 MJMessage 和 MJConversation, 请自己初始化数据库
 
 这里可以使用默认的MJMessage MJConversation, 也有可能使用它们的之类, 根据自己需求处理
 */
+ (void)DBInit;




@end
