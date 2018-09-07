//
//  MJImageMessageBody.h
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//  图片消息体

#import "MJFileMessageBody.h"

@interface MJImageMessageBody : MJFileMessageBody

/// 原图附件的尺寸
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


- (instancetype)initWithImage:(UIImage *)image;

@end
