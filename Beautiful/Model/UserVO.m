//
//  UserVO.m
//  Beautiful
//
//  Created by S on 16/1/25.
//  Copyright © 2016年 B. All rights reserved.
//

#import "UserVO.h"

@implementation UserVO
- (void)dealloc
{
    self.token = nil;
    self.iconUrl = nil;
    self.username = nil;
    self.phone = nil;
}

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.iconUrl forKey:@"iconUrl"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.phone forKey:@"phone"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.token = [decoder decodeObjectForKey:@"token"];
        self.iconUrl = [decoder decodeObjectForKey:@"iconUrl"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
    }
    return self;
}


@end
