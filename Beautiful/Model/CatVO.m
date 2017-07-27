//
//  CatVO.m
//  Beautiful
//
//  Created by admin on 17/5/15.
//  Copyright © 2017年 B. All rights reserved.
//

#import "CatVO.h"

@implementation CatVO
//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.categoryId forKey:@"categoryId"];
    [encoder encodeObject:self.category forKey:@"category"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.categoryId = [decoder decodeObjectForKey:@"categoryId"];
        self.category = [decoder decodeObjectForKey:@"category"];
    }
    return self;
}

@end
