//
//  MJVoiceMessageBody.h
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//  语音消息体

#import "MJFileMessageBody.h"

@interface MJVoiceMessageBody : MJFileMessageBody

/// 语音时长, 秒为单位
@property (nonatomic, assign) int duration;

@end
