//
//  MJMessageBody.h
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//  消息体(分语音, 文字, 图片等)

#import "DBModel.h"
#import "MJMessageHeader.h"

@interface MJMessageBody : DBModel

@property (nonatomic, assign, readonly) MJMessageBodyType type;

@end
