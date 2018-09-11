//
//  MJMessage.h
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//  聊天的Message类

#import <DBModel.h>
@class MJMessageBody;

@interface MJMessage : DBModel

/// 数据库主键id
@property (nonatomic, strong) NSNumber<Primary> *primaryId;

/// 消息的唯一标识符id
@property (nonatomic, strong) NSNumber<DBInt> *messageId;

/// 收到的信息的id 记录标记用户有没有收到信息 有没有读
@property (nonatomic, strong) NSNumber<DBInt> *userMessageId;

/// 关联我的会话列表ID
@property (nonatomic, copy) NSString *conversationId;

/// 收到消息时 发消息人的id
@property (nonatomic, strong) NSNumber<DBInt> *senderId;

/// 消息的方向 参照LCMessageDirection
@property (nonatomic, strong) NSNumber<DBInt> *direction;

/// 消息的类型 同LCMessageBodyType
@property (nonatomic, strong) NSNumber<DBInt> *messageType;

/// 消息内容
@property (nonatomic, copy) NSString *messageContent;

/// 消息发送状态 参照LCMessageStatus
@property (nonatomic, strong) NSNumber<DBInt> *sendStatus;

/// 接受的消息 是否已读 0 1
@property (nonatomic, strong) NSNumber<DBInt> *isRead;

/// 语音消息是否已读
@property (nonatomic, strong) NSNumber<DBBool> *isMediaPlayed;

/// 添加时间
@property (nonatomic, copy) NSString *createTime;

/// 可以自己扩展extension
@property (nonatomic, strong) NSDictionary *extension;

/**
 初始化消息实例
 
 @param aConversationId 会话ID
 @param aBody 消息体实例
 @return LCMessage
 */
- (instancetype)initWithConversationID:(NSString *)aConversationId
                                  body:(MJMessageBody *)aBody;


@end
