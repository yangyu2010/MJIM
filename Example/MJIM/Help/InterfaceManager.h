//
//  InterfaceManager.h
//  LimitChat
//
//  Created by Yang Yu on 2018/5/22.
//  Copyright © 2018 Musjoy. All rights reserved.
//  处理网络请求相关

#import <Foundation/Foundation.h>
#import <ActionProtocol.h>

/// 1.1用户注册接口
static NSString *const API_USER_REGISTER             = @"User.register";
/// 1.2用户登录接口
static NSString *const API_USER_LOGIN                = @"User.login";
/// 1.3检查UUID是否已经注册过
static NSString *const API_USER_CHECKUUID            = @"User.checkUUID";
/// 1.4检查昵称是否已经注册过
static NSString *const API_USER_CHECKNICKNAME        = @"User.checkNickName";
/// 1.5兴趣爱好列表
static NSString *const API_USER_GETHOTINTERESTS      = @"User.getHotInterests";

/// 1.6改变基本信息（需授权）
static NSString *const API_USER_CHANGEUSERINFO       = @"User.changeUserInfo";
/// 1.7用户主页
static NSString *const API_USER_USERHOMEPAGE         = @"User.userHomePage";


/// 2.1热门话题列表
static NSString *const API_BBS_GETHOTTOPICS          = @"BBS.getHotTopics";
/// 2.2添加话题
static NSString *const API_BBS_ADDTOPIC              = @"BBS.addTopic";
/// 2.3发布帖子
static NSString *const API_BBS_ADDBBS                 = @"BBS.addBBS";
/// 2.3读帖子
static NSString *const API_BBS_READBBS              = @"BBS.readBBS";
/// 2.5帖子点赞或取消点赞
static NSString *const API_BBS_LIKEBBS              = @"BBS.likeBBS";
/// 2.6举报帖子
static NSString *const API_BBS_REPORTBBS              = @"BBS.reportBBS";
/// 2.7举报用户
static NSString *const API_BBS_REPORTUSER              = @"BBS.reportUser";
/// 2.8删除帖子
static NSString *const API_BBS_DELETEBBS              = @"BBS.deleteBBS";

/// 3.1选择话题搜索
static NSString *const API_SEARCH_SEARCHBYTOPIC        = @"Search.searchByTopicNew";
/// 3.2其他用户主页
static NSString *const API_SEARCH_OTHERUSERHOMEPAGE        = @"Search.otherUserHomePage";


/// 4.1 发起聊天
static NSString *const API_CHAT_CHAT            = @"Chat.chat";
/// 4.2 屏蔽聊天
static NSString *const API_CHAT_SHIELDCHAT        = @"Chat.shieldChat";

/// 6.1绑定用户和gatewayworker推送id
static NSString *const API_SOCKET_BINDUID        = @"Socket.bindUid";
/// 6.2拉取用户信息
static NSString *const API_SOCKET_PULLMESSAGE        = @"Socket.pullMessage";
/// 6.3聊天
static NSString *const API_SOCKET_CHAT           = @"Socket.chat";
/// 6.4用户收到消息和读取消息
static NSString *const API_SOCKET_PROCESSUSERMESSAGE           = @"Socket.processUserMessage";
/// 6.5用户读取消息（会话框）
static NSString *const API_SOCKET_USERREADMESSAGE           = @"Socket.userReadMessage";
/// 6.6获取会话信息
static NSString *const API_SOCKET_GETCHATINFO           = @"Socket.getChatInfo";



@interface InterfaceManager : NSObject

/// 授权请求
+ (void)startAuthRequest:(NSString *)action
                describe:(NSString *)describe
                    body:(NSDictionary *)body
              completion:(ActionCompleteBlock)completion;

/// 普通请求 未授权
+ (void)startRequest:(NSString *)action
            describe:(NSString *)describe
                body:(NSDictionary *)body
              header:(NSDictionary *)header
          completion:(ActionCompleteBlock)completion;


@end
