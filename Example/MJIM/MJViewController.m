//
//  MJViewController.m
//  MJIM
//
//  Created by yangyu2010@aliyun.com on 08/28/2018.
//  Copyright (c) 2018 yangyu2010@aliyun.com. All rights reserved.
//

#import "MJViewController.h"
#import <MJWebSocketMgr.h>
#import "MJSocketMessageHandle.h"

@interface MJViewController ()

@property (nonatomic, strong) MJSocketMessageHandle *handle;

@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.handle = [MJSocketMessageHandle new];
    [[MJWebSocketMgr sharedInstance] setHandler:self.handle];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
