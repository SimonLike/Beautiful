//
//  OrderCouponCell.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCouponCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* cashCoupon;
+ (OrderCouponCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)vo;
@end
