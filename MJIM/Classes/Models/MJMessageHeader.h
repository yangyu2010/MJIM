//
//  MJMessageHeader.h
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//  消息的一些枚举


/// 聊天类型
typedef enum : NSUInteger {
    MJChatTypeChat = 0,     /// 单聊消息
    MJChatTypeGroupChat,    /// 群聊消息
    MJChatTypeChatRoom,     /// 聊天室消息
} MJChatType;



/// 消息发送状态
typedef enum : NSUInteger {
    MJMessageStatusPending  = 0,    /// 发送未开始
    MJMessageStatusDelivering,      /// 正在发送
    MJMessageStatusSucceed,         /// 发送成功
    MJMessageStatusFailed,          /// 发送失败
} MJMessageStatus;


/// 消息方向
typedef enum : NSUInteger {
    MJMessageDirectionSend = 0,     /// 发送的消息
    MJMessageDirectionReceive,      /// 接收的消息
} MJMessageDirection;


/// 消息体类型
typedef enum : NSUInteger {
    MJMessageBodyTypeText   = 0,    /// 文本类型
    MJMessageBodyTypeVoice,         /// 语音类型
    MJMessageBodyTypeImage,         /// 图片类型
    MJMessageBodyTypeVideo,         /// 视频类型
    MJMessageBodyTypeLocation,      /// 位置类型
    MJMessageBodyTypeFile,          /// 文件类型
    MJMessageBodyTypeCmd,           /// 命令类型
} MJMessageBodyType;


/// 附件下载状态
typedef enum : NSUInteger {
    MJDownloadStatusDownloading   = 0,  /// 正在下载
    MJDownloadStatusSucceed,            /// 下载成功
    MJDownloadStatusFailed,             /// 下载失败
    MJDownloadStatusPending,            /// 准备下载
} MJDownloadStatus;


