//
//  MineHeaderCell.h
//  Manage
//
//  Created by S on 15/12/16.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineHeaderDelegate <NSObject>

- (void)back;
- (void)userInfo;
- (void)setting;
@end

@interface MineHeaderCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) id<MineHeaderDelegate>delegate;
+ (MineHeaderCell*)getInstanceWithNib;
- (void)setUI;
@end
