//
//  MJImageMessageBody.m
//  AFNetworking
//
//  Created by Yang Yu on 2018/9/7.
//

#import "MJImageMessageBody.h"

@implementation MJImageMessageBody

- (instancetype)initWithImage:(UIImage *)image {
    
    self = [super init];
    if (self) {

        _width = image.size.width;
        _height = image.size.height;

    }
    return self;
}

- (MJMessageBodyType)type {
    return MJMessageBodyTypeImage;
}

@end
