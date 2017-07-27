//
//  AppointHeadCell.h
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointHeadCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UILabel* perPrice;
@property (nonatomic, strong) IBOutlet UILabel* totalPrice;
+ (AppointHeadCell*)getInstanceWithNib;
- (void)setUI:(ProductVO*)aVO;
@end
