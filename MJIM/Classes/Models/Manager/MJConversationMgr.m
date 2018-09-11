//
//  MJConversationMgr.m
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//

#import "MJConversationMgr.h"
#import "MJConversation.h"
#import "MJMessageMgr.h"
#import <DBModel/DBManager.h>

@implementation MJConversationMgr

/// 插入Conversation
+ (BOOL)insertConversation:(MJConversation *)conversation {
    if (conversation) {
        return [DBManager insertModel:conversation];
    }
    return NO;
}

/// 更新Conversation
+ (BOOL)updateConversation:(MJConversation *)conversation {
    if (conversation) {
        return [DBManager updateModel:conversation];
    }
    return NO;
}

/// 删除会话, 同时需要删除会话的所有消息
+ (BOOL)removeConversation:(MJConversation *)conversation {
    if (conversation) {
        [DBManager deleteModelList:@[conversation]];
        return [self removeAllMesasgeWithConversationId:conversation.conversationId];
    }
    
    return NO;
}




#pragma mark- Get

/// 获取所有的会话
+ (NSArray <MJConversation *> *)getAllConversation {
    return [DBManager findModelList:[MJConversation class] withWhereSql:@"" orderBy:@"lastChatTime DESC"];
}


/// 获取所有的会话id
+ (NSArray <NSString *>*)getAllConversationId {
    NSString *sql = [NSString stringWithFormat:@"select conversationId from %@", [MJConversation tableName]];
    
    FMResultSet *result =  [[DBManager sharedInstance] executeQuery:sql];
    
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        NSString *conversationId = [result stringForColumn:@"conversationId"];
        [arr addObject:conversationId];
    }
    
    return arr;
}

/// 根据conversationId获取会话
+ (MJConversation *)getConversationWithConversationId:(NSString *)conversationId {
    NSString *sql = [NSString stringWithFormat:@"conversationId = %@", conversationId];
    MJConversation *model = [DBManager findModel:[MJConversation class] withWhereSql:sql];
    return model;
}

/// 检查和某个人的聊天是否已经创建
+ (MJConversation *)getConversationWithUserId:(NSString *)userId {
    
    NSString *sql = [NSString stringWithFormat:@"userId = %@", userId];
    MJConversation *model = [DBManager findModel:[MJConversation class] withWhereSql:sql];
    return model;
}


#pragma mark- Private

/// 删除会话的所有消息
+ (BOOL)removeAllMesasgeWithConversationId:(NSString *)conversationId {
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE conversationId = %@", [MJMessage tableName], conversationId];
    FMResultSet *result = [[DBManager sharedInstance] executeQuery:strSql];
    return result.next;
}

@end
