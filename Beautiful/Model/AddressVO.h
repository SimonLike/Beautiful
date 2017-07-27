//
//  AddressVO.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressVO : NSObject
@property (nonatomic, strong) NSString* addressId;
@property (nonatomic, strong) NSString* name; 
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* province;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* county;
@property (nonatomic, strong) NSString* detail;
@property (nonatomic, strong) NSString* def;

@end
//"addrId": "1",
//"name": "李四",
//"phone": "13153535353",
//"province": "四川省",
//"city": "成都市",
//"county": "武侯区",
//"detail": "佳灵路",
//"def": 0
