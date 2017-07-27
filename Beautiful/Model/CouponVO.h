//
//  CouponVO.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponVO : NSObject
@property (nonatomic, strong) NSString* worth;
@property (nonatomic, strong) NSString* deadline;
@property (nonatomic, strong) NSString* status;//0-全部、1-未使用、2-已使用、3-已过期
@property (nonatomic, strong) NSString* cashCouponId;
@property (nonatomic, strong) NSString* couponNo;
@property (nonatomic, strong) NSString* isSelected;
@end
