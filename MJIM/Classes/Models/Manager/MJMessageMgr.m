//
//  MJMessageMgr.m
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//

#import "MJMessageMgr.h"
#import "DBManager.h"

@implementation MJMessageMgr

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


@end
