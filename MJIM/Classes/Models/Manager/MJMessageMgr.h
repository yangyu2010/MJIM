//
//  MJMessageMgr.h
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//  管理消息Message的

#import <Foundation/Foundation.h>
#import "MJMessage.h"

@interface MJMessageMgr : NSObject


#pragma mark- Message数据库操作

/// 获取Message
+ (NSArray <MJMessage *> *)getConversationMessageWithId:(NSString *)conversationId;

/// 移除Message
+ (BOOL)removeConversationMessageWithId:(NSString *)conversationId;

/// 插入Message
+ (BOOL)insertMessage:(MJMessage *)message;

/// 更新Message
+ (BOOL)updateMessage:(MJMessage *)message;

/// 更新Message
+ (BOOL)updateSendMessageStatus:(NSString *)primaryId
                        isSucceed:(BOOL)isSucceed;




#pragma mark- 创建 Message


/**
 创建一个文本Message
 
 @param chatId 会话id
 @param text 文本
 @return MJMessage
 */
+ (MJMessage *)getTextMessageWithChatId:(NSString *)chatId
                                   text:(NSString *)text;


/**
 创建一个image message

 @param chatId 会话id
 @param image 图片
 @param localPath 本地路径
 @param remotePath 远程路径
 @return MJMessage
 */
+ (MJMessage *)getImageMessageWithChatId:(NSString *)chatId
                                   image:(UIImage *)image
                               localPath:(NSString *)localPath
                              remotePath:(NSString *)remotePath;



/**
 创建一个音频 message

 @param chatId 会话id
 @param localPath 音频本地路径
 @param remotePath 音频远程路径
 @param duration 音频大小
 @return MJMessage
 */
+ (MJMessage *)getAudioMessageWithChatId:(NSString *)chatId
                               localPath:(NSString *)localPath
                              remotePath:(NSString *)remotePath
                                duration:(float)duration;



@end
