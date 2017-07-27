//
//  AppointCell.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* orderNum;
@property (nonatomic, strong) IBOutlet UILabel* titile;
@property (nonatomic, strong) IBOutlet UILabel* money;
@property (nonatomic, strong) IBOutlet UILabel* status;
@property (nonatomic, strong) IBOutlet UILabel* payMoney;
@property (nonatomic, strong) IBOutlet UIImageView* icon;
+ (AppointCell*)getInstanceWithNib;
- (void)setUI:(AppointVO*)aVO;
@end
