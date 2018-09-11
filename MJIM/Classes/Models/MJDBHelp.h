//
//  MJDBHelp.h
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/11.
//  数据库操作

#import <Foundation/Foundation.h>

/// 数据库名称
#ifndef THE_IM_DB_NAME
#define THE_IM_DB_NAME  @"com.musjoy.iOS"
#endif

/// Message 消息类
#ifndef THE_IM_DB_MESSAGE
#define THE_IM_DB_MESSAGE  ([MJMessage tableName])
#endif

/// Conversation 会话类
#ifndef THE_IM_DB_CONVERSATION
#define THE_IM_DB_CONVERSATION  ([MJConversation tableName])
#endif



@interface MJDBHelp : NSObject

/**
 初始化数据库, 在didFinishLaunchingWithOptions里调用
 如果你使用的不是 MJMessage 和 MJConversation
 请自己定义 THE_IM_DB_MESSAGE THE_IM_DB_CONVERSATION
 同时自己处理Manager中Get方法
 
 这里可以使用默认的MJMessage MJConversation, 也有可能使用它们的之类, 根据自己需求处理
 */
+ (void)DBInit;




@end
