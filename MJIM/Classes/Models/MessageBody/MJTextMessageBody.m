//
//  MJTextMessageBody.m
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//

#import "MJTextMessageBody.h"

@implementation MJTextMessageBody

/**
 初始化文本消息体
 */
- (instancetype)initWithText:(NSString *)aText {
    
    self = [super init];
    if (self) {
        _text = aText;
    }
    return self;
    
}


- (MJMessageBodyType)type {
    return MJMessageBodyTypeText;
}

@end
