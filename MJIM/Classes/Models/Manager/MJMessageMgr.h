//
//  MJMessageMgr.h
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//  管理消息Message的

#import <Foundation/Foundation.h>
#import "MJMessage.h"

typedef void(^GetMessageListBlock)(NSArray <MJMessage *> *);

typedef void(^HandleMessageSucceedBlock)(BOOL isSucceed);

@interface MJMessageMgr : NSObject

+ (void)getConversationMessageWithId:(NSString *)conversationId
                          completion:(GetMessageListBlock)completion;

+ (void)removeConversationMessageWithId:(NSString *)conversationId
                             completion:(HandleMessageSucceedBlock)completion;


+ (void)insertMessage:(MJMessage *)message
           completion:(HandleMessageSucceedBlock)completion;

+ (void)updateMessage:(MJMessage *)message
           completion:(HandleMessageSucceedBlock)completion;


@end
