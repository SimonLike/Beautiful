//
//  MoneyVO.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoneyVO : NSObject
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* amount;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* status;
//@property (nonatomic, strong) NSString* isDefault;
@end
//"time": "2016-11-30 12:30:45",
//"type": 0,//0-返现、1-提现
//"amount": "xxx",
//"status": 0,//只有提现才有该字段，0-审核中、1-拒绝、2-提现成功
//"desc": "xxxx"
