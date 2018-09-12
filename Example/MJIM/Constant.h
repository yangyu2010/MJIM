//
//  Constant.h
//  LimitChat
//
//  Created by Yang Yu on 2018/5/22.
//  Copyright © 2018 Musjoy. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//#define kBaseHost               @"https://localapp.musjoy.com"
//#define kServerBaseHost         @"https://localapp.musjoy.com"
//#define kServerPath             @"/apps/LimitChat/LimitChat20/"


#define kBaseHost               @"http://192.168.88.134"
#define kServerBaseHost         @"http://192.168.88.134"
#define kServerPath             @"/WebServer/www/apps/limitchat/limitchat4/"

#define kBaseUrl                  combine(kBaseHost, kServerPath)
#define kServerUrl                combine(kServerBaseHost, kServerPath)
#define kServerAction             combine(kServerUrl, @"action/")


//#define THE_IM_DB_MESSAGE        @"LCMessage"
//#define THE_IM_DB_CONVERSATION   @"LCConversation"


/// MARK: - Notification

/// 接收到一个会话
#define kNotificationReceiveConversation    @"kNotificationReceiveConversation"
/// 需要更新会话
#define kNotificationUpdateConversation    @"kNotificationUpdateConversation"
/// 接收到一个消息
#define kNotificationReceiveMessage         @"kNotificationReceiveMessage"



#endif /* Constant_h */
