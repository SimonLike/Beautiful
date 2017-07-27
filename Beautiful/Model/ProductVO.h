//
//  ProductVO.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductVO : NSObject
@property (nonatomic, strong) NSString* pic;
@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) NSString* productId;//产品id
@property (nonatomic, strong) NSString* serviceId;//服务id
@property (nonatomic, strong) NSString* cartId;//购物车中id
@property (nonatomic, strong) NSString* collectionId;//购物车中id

@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* num;//购买数量
@property (nonatomic, strong) NSString* isDrawCoupon;
//标准产品数据

//@property (nonatomic, strong) NSString* saleNum;
@property (nonatomic, strong) NSString* buyNum;
@property (nonatomic, strong) NSString* cashBack;
@property (nonatomic, strong) NSString* isCollected;

@property (nonatomic, strong) NSString* selectNum;
@property (nonatomic, strong) NSString* isSelected;
@end

//"productId": "xxxxxxxxxxx",
//"pic": "["xxxx","xxxx"]",
//"title": "xxxxxxx",
//"price": "xxx",
//"num": 10,
//"isDrawCoupon": 1//是否返券 1返券0不返券
