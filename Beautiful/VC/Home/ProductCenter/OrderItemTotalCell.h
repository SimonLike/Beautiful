//
//  OrderItemTotalCell.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderItemTotalCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* totalLabel;
+ (OrderItemTotalCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)vo;
- (void)setPayUI:(OrderVO*)vo;
@end
