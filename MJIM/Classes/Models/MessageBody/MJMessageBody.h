//
//  MJMessageBody.h
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//  消息体(分语音, 文字, 图片等)

#import <Foundation/Foundation.h>
#import "MJMessageHeader.h"

@interface MJMessageBody : NSObject

@property (nonatomic, assign, readonly) MJMessageBodyType type;

@end
