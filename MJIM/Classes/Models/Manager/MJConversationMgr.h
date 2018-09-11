//
//  MJConversationMgr.h
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//  管理会话Conversation的
//  数据库相关操作请保证在同一个线程, 一般都是main

#import <Foundation/Foundation.h>
@class MJConversation;


@interface MJConversationMgr : NSObject


#pragma mark- Conversation数据库操作

/// 插入Conversation
+ (BOOL)insertConversation:(MJConversation *)conversation;

/// 更新Conversation
+ (BOOL)updateConversation:(MJConversation *)conversation;

/// 删除会话, 同时需要删除会话的所有消息
+ (BOOL)removeConversation:(MJConversation *)conversation;





#pragma mark- Get

/// 获取所有的会话
+ (NSArray <MJConversation *> *)getAllConversation;

/// 获取所有的会话id
+ (NSArray <NSString *>*)getAllConversationId;

/// 根据conversationId获取会话
+ (MJConversation *)getConversationWithConversationId:(NSString *)conversationId;

/// 检查和某个人的聊天是否已经创建
+ (MJConversation *)getConversationWithUserId:(NSString *)userId;





@end
