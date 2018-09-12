//
//  MJViewController.m
//  MJIM
//
//  Created by yangyu2010@aliyun.com on 08/28/2018.
//  Copyright (c) 2018 yangyu2010@aliyun.com. All rights reserved.
//

#import "MJViewController.h"

#import <MJIM/MJModels.h>
#import <MJWebSocketMgr.h>

#import "MJSocketMessageHandle.h"
#import "InterfaceManager.h"
#import "Constant.h"

@interface MJViewController ()

@property (nonatomic, strong) MJSocketMessageHandle *handle;


@property (weak, nonatomic) IBOutlet UILabel *textLab;
@property (weak, nonatomic) IBOutlet UITextField *field;


@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.handle = [MJSocketMessageHandle new];
    [[MJWebSocketMgr sharedInstance] setHandler:self.handle];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(actionReceiveMessage:)
                                                 name:kNotificationReceiveMessage
                                               object:nil];

}



/// 监听通知, 收到消息
- (void)actionReceiveMessage:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[MJMessage class]] == NO) {
        return ;
    }
    
    MJMessage *message = (MJMessage *)notification.object;
    
    NSLog(@"收到聊天消息");
    
    self.textLab.text = message.messageContent;
}



/**
 {
 chatId = 365;
 createTime = 1536659258;
 direction = 0;
 isRead = 0;
 messageContent = "{\"type\":0,\"text\":\"\U6211\"}";
 messageType = 0;
 primaryId = 1;
 sendStatus = 1;
 }
 */
- (IBAction)send:(id)sender {
    if (_field.text.length == 0) {
        return ;
    }
    

    MJMessage *aMessage = [MJMessageMgr getTextMessageWithId:@"179" text:_field.text];
    
    NSDictionary *body = @{
                           @"chatId": aMessage.chatId,
                           @"messageType": aMessage.messageType,
                           @"messageContent": aMessage.messageContent,
                           @"primaryId": [NSString stringWithFormat:@"%@", aMessage.primaryId],
                           @"devicePushId": @"0",
                           };
    
    [InterfaceManager startAuthRequest:API_SOCKET_CHAT describe:API_SOCKET_CHAT body:body completion:^(BOOL isSucceed, NSString *message, id data) {
        if (isSucceed) {
            NSLog(@"发送成功");
        } else {
            NSLog(@"发送失败");
        }
        
        self.field.text = @"";
    }];


    
//    MJTextMessageBody *body = [[MJTextMessageBody alloc] initWithText:_textLab.text];
//
//    MJMessage *message = [MJMessage alloc] ;
    
}


@end
