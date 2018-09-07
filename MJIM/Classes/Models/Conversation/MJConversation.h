//
//  MJConversation.h
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//  会话model

#import <DBModel.h>

@interface MJConversation : DBModel

/// 当前会话对应的主键id
@property (nonatomic, strong) NSNumber<Primary> *primaryId;

/// 当前会话对应的ID
@property (nonatomic, copy) NSString *conversationId;

/// 聊天人的id，以后做群里id已，分割
@property (nonatomic, copy) NSString *userId;

/// 会话类型 参照 LCChatType
@property (nonatomic, strong) NSNumber<DBInt> *conversationType;

/// 未读个数
@property (nonatomic, strong) NSNumber<DBInt> *unreadCount;

/// 最后聊天时间
@property (nonatomic, copy) NSString *lastChatTime;

/// 最后一条message
@property (nonatomic, copy) NSString *lastMessage;

/// 聊天对象的info
@property (nonatomic, copy) NSString *userInfo;

/// 会话创建时间
@property (nonatomic, copy) NSString *createTime;

/// 该会话是否屏蔽 0没有屏蔽 1被自己屏幕 2被他人屏蔽
@property (nonatomic, strong) NSNumber<DBInt> *shield;


@end
