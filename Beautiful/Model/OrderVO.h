//
//  OrderVO.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeamVO.h"
@interface OrderVO : NSObject
@property (nonatomic, strong) NSString* addrId;
@property (nonatomic, strong) NSString* orderType;
@property (nonatomic, strong) NSString* orderNo;
@property (nonatomic, strong) NSString* totalNum;
@property (nonatomic, strong) NSString* totalPrice;
@property (nonatomic, strong) NSString* totalPay;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* createTime;
@property (nonatomic, strong) NSString* payTime;
@property (nonatomic, strong) NSString* payType;
@property (nonatomic, strong) NSString* deliveryType;
@property (nonatomic, strong) NSString* cashCoupon;
@property (nonatomic, strong) NSString* cashCouponID;
@property (nonatomic, strong) NSString* receiveTime;
@property (nonatomic, strong) NSMutableArray* products;
@property (nonatomic, strong) TeamVO* team;
@end
//"orderType": 0,// 0-待付款、1-待发货、2-待收货、3-已完成
//"orderNo": "商品订单号",
//"totalNum": 10,
//"totlePrice": "xxx",//合计金额
//"totalPay": "xxxx",//实付金额
//"name": "收货人姓名",
//"phone": "收货人电话",
//"address": "收货人地址",
//"createTime": "2016-01-28 12:30:12",
//"payTime": "2016-01-28 12:30:12",//待支付订单没有该字段
//"payType": "支付宝",//待支付订单没有该字段
//"deliveryType": "快递",//待支付订单没有该字段
//"cashCoupon": "抵扣金额",//待支付订单没有该字段
//"products": [
//             {
//                 "productId": "xxxxxxxxxxx",
//                 "pic": "xxxxxxx/xxxxxxxxxxx",
//                 "title": "xxxxxxx",
//                 "price": "xxx",
//                 "buyNum": 2
//             }
//             ]
