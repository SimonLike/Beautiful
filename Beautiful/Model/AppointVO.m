//
//  AppointVO.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AppointVO.h"

@implementation AppointVO
- (NSDictionary *)objectClassInArray
{
    return @{@"service" : [ProductVO class]};
}
@end
