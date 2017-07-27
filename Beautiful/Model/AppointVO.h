//
//  AppointVO.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductVO.h"
@interface AppointVO : NSObject
@property (nonatomic, strong) NSString* teamNo;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* pic;
@property (nonatomic, strong) NSString* teamType;// 0-进行中 1-参与成功
//@property (nonatomic, strong) NSString* totalNum;
@property (nonatomic, strong) NSString* totalPrice;//合计金额
@property (nonatomic, strong) NSString* totalPay;//实付金额
@property (nonatomic, strong) NSString* name;// 收货人姓名
@property (nonatomic, strong) NSString* phone;// 收货人电话
@property (nonatomic, strong) NSString* address;// 收货人地址
@property (nonatomic, strong) NSString* createTime;// 2016-01-28 12:30:12
@property (nonatomic, strong) NSString* leftTime;// 10000（秒为单位）
@property (nonatomic, strong) NSString* totalNum;//
@property (nonatomic, strong) NSString* leftNum;//
@property (nonatomic, strong) NSString* payTime;// 2016-01-28 12:30:12",//待支付订单没有该字段
@property (nonatomic, strong) NSString* payType;// 支付宝",//待支付订单没有该字段
@property (nonatomic, strong) NSString* cashCoupon;//抵扣金额",//待支付订单没有该字段
//@property (nonatomic, strong) ProductVO* products;
@end
//"orderNo": "订单号",
//"consume": 0,//0-未消费,1-已消费
//"totalPrice": "xxx",
//"totalPay": "xxxx",
//"createTime": "2016-01-28 12:30:12",
//"subscribeTime": "2016-01-28 12:30:12",//预约时间
//"payTime": "2016-01-28 12:30:12",
//"payType": "支付宝",
//"cashCoupon": "抵扣金额",
//"service": {
//    "serviceId": "xxxxxxxxxxx",
//    "pic": "["xxxx","xxxx"]",
//    "title": "xxxxxxx",
//    "price": "xxx"
//}
