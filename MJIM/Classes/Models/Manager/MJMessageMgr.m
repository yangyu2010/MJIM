//
//  MJMessageMgr.m
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//

#import "MJMessageMgr.h"
#import "DBManager.h"
#import "MJMessageHeader.h"
#import "MJTextMessageBody.h"
#import "MJImageMessageBody.h"
#import "MJVoiceMessageBody.h"


@implementation MJMessageMgr


#pragma mark- Message数据库操作


#pragma mark- Get Message
+ (void)getConversationMessageWithId:(NSString *)conversationId completion:(GetMessageListBlock)completion {
    
    if (conversationId == nil ||
        conversationId.length == 0) {
        completion ? completion(nil) : nil;
        return ;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        NSString *sql = [NSString stringWithFormat:@"(conversation = %@)", conversationId];
        NSArray *arrMessage = [DBManager findModelList:[MJMessage class] withWhereSql:sql];
        completion ? completion(arrMessage) : nil;
    });
}

+ (NSArray <MJMessage *> *)getConversationMessageWithId:(NSString *)conversationId {
    if (conversationId.length == 0) {
        return nil;
    }
    NSString *sql = [NSString stringWithFormat:@"(conversation = %@)", conversationId];
    NSArray *arrMessage = [DBManager findModelList:[MJMessage class] withWhereSql:sql];
    return arrMessage;
}



#pragma mark- Remove Message
+ (void)removeConversationMessageWithId:(NSString *)conversationId
                             completion:(HandleMessageSucceedBlock)completion {
    
    if (conversationId == nil ||
        conversationId.length == 0) {
        completion ? completion(NO) : nil;
        return ;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *strSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE conversationId = %@", [MJMessage tableName], conversationId];
        FMResultSet *result = [[DBManager sharedInstance] executeQuery:strSql];
        completion ? completion(result.next) : nil;
    });
}

+ (BOOL)removeConversationMessageWithId:(NSString *)conversationId {
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE conversationId = %@", [MJMessage tableName], conversationId];
    FMResultSet *result = [[DBManager sharedInstance] executeQuery:strSql];
    return result.next;
}



#pragma mark- Insert Message
+ (void)insertMessage:(MJMessage *)message
           completion:(HandleMessageSucceedBlock)completion {
    if (message == nil) {
        completion ? completion(NO) : nil;
        return ;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL succeed = [DBManager insertModel:message];
        completion ? completion(succeed) : nil;
    });
}
+ (BOOL)insertMessage:(MJMessage *)message {
    if (message == nil) {
        return NO;
    }
    BOOL succeed = [DBManager insertModel:message];
    return succeed;
}



#pragma mark- Update Message
+ (void)updateMessage:(MJMessage *)message
           completion:(HandleMessageSucceedBlock)completion {
    
    if (message == nil) {
        completion ? completion(NO) : nil;
        return ;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL succeed = [DBManager updateModel:message];
        completion ? completion(succeed) : nil;
    });
}

+ (BOOL)updateMessage:(MJMessage *)message {
    if (message == nil) {
        return NO;
    }
    
    BOOL succeed = [DBManager updateModel:message];
    return succeed;
}

+ (void)updateSendMessageStatus:(NSString *)primaryId
                      isSucceed:(BOOL)isSucceed
                     completion:(HandleMessageSucceedBlock)completion {
    
    if (primaryId == nil ||
        primaryId.length == 0) {
        completion ? completion(NO) : nil;
        return ;
    }
    
    NSString *sql = [NSString stringWithFormat:@"primaryId = %@",primaryId];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MJMessage *message = [DBManager findModel:[MJMessage class] withWhereSql:sql];
        if (isSucceed) {
            message.sendStatus = (NSNumber<DBInt> *)[NSNumber numberWithInteger: MJMessageStatusSucceed];
        } else {
            message.sendStatus = (NSNumber<DBInt> *)[NSNumber numberWithInteger: MJMessageStatusFailed];
        }
        BOOL succeed = [DBManager updateModel:message];
        completion ? completion(succeed) : nil;
    });
    
}

+ (BOOL)updateSendMessageStatus:(NSString *)primaryId
                      isSucceed:(BOOL)isSucceed {
    if (primaryId == nil ||
        primaryId.length == 0) {
        return NO;
    }
    
    NSString *sql = [NSString stringWithFormat:@"primaryId = %@",primaryId];
    MJMessage *message = [DBManager findModel:[MJMessage class] withWhereSql:sql];
    if (isSucceed) {
        message.sendStatus = (NSNumber<DBInt> *)[NSNumber numberWithInteger:MJMessageStatusSucceed];
    } else {
        message.sendStatus = (NSNumber<DBInt> *)[NSNumber numberWithInteger:MJMessageStatusFailed];
    }
    
    BOOL succeed = [DBManager updateModel:message];
    return succeed;
}


#pragma mark- 创建 Message

/**
 创建一个文本Message
 */
+ (MJMessage *)getTextMessageWithChatId:(NSString *)chatId
                                   text:(NSString *)text {
    
    MJTextMessageBody *body = [[MJTextMessageBody alloc] initWithText:text];
    MJMessage *message = [[MJMessage alloc] initWithConversationID:chatId body:body];
    
    long long primaryId = [DBManager insertModelGetId:message];
    //    NSLog(@"getTextMessage_primaryId: %lld", primaryId);
    message.primaryId = (NSNumber<Primary> *)[NSNumber numberWithLongLong:primaryId];
    return message;
}


/**
 创建一个image message
 */
+ (MJMessage *)getImageMessageWithChatId:(NSString *)chatId
                                   image:(UIImage *)image
                               localPath:(NSString *)localPath
                              remotePath:(NSString *)remotePath {
    
    
    
    MJImageMessageBody *body = [[MJImageMessageBody alloc] initWithImage:image];
    body.localPath = localPath;
    body.remotePath = remotePath ;

    MJMessage *message = [[MJMessage alloc] initWithConversationID:chatId body:body];

    BOOL is = [DBManager insertModel:message];
    if (is) {
        NSDictionary *dict = @{@"conversationId" : message.conversationId,
                               @"direction": message.direction,
                               @"createTime": message.createTime,
                               };
        return [DBManager findModel:[MJMessage class] inCondition:dict];
    }

    return nil;
}

/**
 创建一个音频 message
 */
+ (MJMessage *)getAudioMessageWithChatId:(NSString *)chatId
                               localPath:(NSString *)localPath
                              remotePath:(NSString *)remotePath
                                duration:(float)duration {
    
    MJVoiceMessageBody *body = [[MJVoiceMessageBody alloc] init];
    body.duration = duration;
    body.localPath = localPath;
    body.remotePath = remotePath ;

    MJMessage *message = [[MJMessage alloc] initWithConversationID:chatId body:body];
    
    BOOL is = [DBManager insertModel:message];
    if (is) {
        NSDictionary *dict = @{@"conversationId" : message.conversationId,
                               @"direction": message.direction,
                               @"createTime": message.createTime,
                               };
        return [DBManager findModel:[MJMessage class] inCondition:dict];
    }
    
    return nil;
    
}

@end










