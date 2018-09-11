//
//  MJDBHelp.m
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/11.
//

#import "MJDBHelp.h"
#import "MJConversation.h"
#import "MJMessage.h"
#import <DBModel/DBManager.h>
#import <ModuleCapability/ModuleCapability.h>

@implementation MJDBHelp

+ (void)DBInit {
    
    NSArray *arrAlbumTables = @[
                                THE_IM_DB_MESSAGE,
                                THE_IM_DB_CONVERSATION,
                                ];
    [[DBManager sharedInstance] openDefaultDB:THE_IM_DB_NAME withTables:arrAlbumTables];

}

@end
