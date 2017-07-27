//
//  ProductDetialVO.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetialVO : NSObject
@property (nonatomic, strong) NSString* productId;
@property (nonatomic, strong) NSString* serviceId;
@property (nonatomic, strong) NSMutableArray* pics;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* num;
@property (nonatomic, strong) NSString* introduce;
@property (nonatomic, strong) NSString* isDrawCoupon;
@property (nonatomic, strong) NSString* couponAmount;
@end
//"productId": "xxxxxxxxxxx",
//"pics": [
//"xxx",
//"xxxxx"
//],
//"title": "xxxxxxx",
//"price": "xxx",
//"num": 10,
//"introduce": "xxxxxxxxxxxxxxxxx"
//"isDrawCoupon": 1//是否返券 1返券0不返券
//"couponAmount": "xxx"//返券金额
