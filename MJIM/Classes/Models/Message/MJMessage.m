//
//  MJMessage.m
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//

#import "MJMessage.h"
#import "MJMessageBody.h"

@implementation MJMessage

/**
 初始化消息实例
 */
- (instancetype)initWithConversationID:(NSString *)aConversationId
                                  body:(MJMessageBody *)aBody {
    
    self = [super init];
    if (self) {
        
        _conversationId = aConversationId;
        _messageContent = aBody.toJSONString;

        _messageType = (NSNumber<DBInt> *)[NSNumber numberWithInteger:aBody.type];
        _direction = (NSNumber<DBInt> *)[NSNumber numberWithInteger:MJMessageDirectionSend];
        _createTime = [NSString stringWithFormat:@".0%f", [[NSDate date] timeIntervalSince1970]];
        _sendStatus = (NSNumber<DBInt> *)[NSNumber numberWithInteger:MJMessageStatusDelivering];
        _isRead = (NSNumber<DBInt> *)[NSNumber numberWithBool:NO];
        
    }
    return self;
    
}

@end
