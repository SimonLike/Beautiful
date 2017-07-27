//
//  OrderNumCell.h
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNumCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* orderNum;
+ (OrderNumCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)oVO;
@end
