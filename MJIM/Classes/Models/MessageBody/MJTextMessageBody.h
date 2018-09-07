//
//  MJTextMessageBody.h
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//  文字消息Body

#import "MJMessageBody.h"

@interface MJTextMessageBody : MJMessageBody

/// 文本内容
@property (nonatomic, copy) NSString *text;

/**
 初始化文本消息体
 
 @param aText 文本内容
 @return 文本消息体实例
 */
- (instancetype)initWithText:(NSString *)aText;


@end
