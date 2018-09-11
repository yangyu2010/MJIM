//
//  MJFileMessageBody.h
//  Pods
//
//  Created by Yang Yu on 2018/9/7.
//  文件消息体 一般不直接使用这个类 可以使用图片，视频，语音等子类

#import <Foundation/Foundation.h>
#import "MJMessageBody.h"
#import "MJMessageHeader.h"

@interface MJFileMessageBody : MJMessageBody

/// 附件的显示名
//@property (nonatomic, copy) NSString *displayName;

/// 附件的本地路径
@property (nonatomic, copy) NSString *localPath;

/// 附件在服务器上的路径
@property (nonatomic, copy) NSString *remotePath;

/// 附件的密钥, 下载附件时需要密匙做校验
//@property (nonatomic, copy) NSString *secretKey;

/// 附件的大小, 以字节为单位
//@property (nonatomic, assign) long long fileLength;

/// 附件的下载状态
@property (nonatomic, assign) MJDownloadStatus downloadStatus;


///**
// 初始化文件消息体
//
// @param aLocalPath 附件本地路径
// @param aDisplayName 附件显示名（不包含路径）
// @return LCFileMessageBody
// */
//- (instancetype)initWithLocalPath:(NSString *)aLocalPath
//                      displayName:(NSString *)aDisplayName;
//
//
///**
// 初始化文件消息体
//
// @param aData 附件数据
// @param aDisplayName 附件显示名（不包含路径）
// @return LCFileMessageBody
// */
//- (instancetype)initWithData:(NSData *)aData
//                 displayName:(NSString *)aDisplayName;


@end
