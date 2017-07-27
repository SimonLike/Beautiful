//
//  SelectCouponVC.h
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Coupon)(CouponVO *model);
@interface SelectCouponVC : UIViewController
@property (nonatomic, strong) IBOutlet UITableView* table;
@property (nonatomic, strong) NSMutableArray* dataAry;
@property (nonatomic, strong) NSString* couponID;
@property (nonatomic, strong) Coupon couponBlock;
@end
