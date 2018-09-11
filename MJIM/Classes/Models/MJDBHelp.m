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

/// 数据库名称
#ifndef THE_ALBUMS_DB_NAME
#define THE_ALBUMS_DB_NAME  @"com.musjoy.iOS"
#endif

@implementation MJDBHelp

+ (void)DBInit {
    
    NSArray *arrAlbumTables = @[
                                [MJConversation tableName],
                                [MJMessage tableName],
                                ];
    [[DBManager sharedInstance] openDefaultDB:THE_ALBUMS_DB_NAME withTables:arrAlbumTables];

}

@end
