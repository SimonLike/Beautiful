//
//  OrderVO.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderVO.h"

@implementation OrderVO
- (NSDictionary *)objectClassInArray
{
    return @{@"products" : [ProductVO class],
             @"team" : [TeamVO class]
             };
}
@end
