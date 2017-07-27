//
//  OrderPayCell.h
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPayCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* payLabel;
@property (nonatomic, strong) IBOutlet UILabel* status;
+ (OrderPayCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)oVO;
@end
