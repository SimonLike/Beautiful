//
//  CashBackVO.h
//  Beautiful
//
//  Created by S on 16/2/17.
//  Copyright © 2016年 B. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashBackVO : NSObject
@property (nonatomic, strong) NSString* productId;
@property (nonatomic, strong) NSString* serviceId;
@property (nonatomic, strong) NSString* productName;
@property (nonatomic, strong) NSString* productPrice;
@property (nonatomic, strong) NSString* productNum;
@property (nonatomic, strong) NSString* pic;
@property (nonatomic, strong) NSString* money;
@property (nonatomic, strong) NSString* sequence;
@end
//"productId": "xxxxxxxxxxx",//productId,serviceId其中一个是null或””
//"productName": "xxxxxx",
//"productPrice": "xxx",
//"productNum": 312,//已销售
//"pic": "xxx",
//"money": "xxxxxxx",//返现金额,为null或””则未返现
//"sequence": 10//购买排序
