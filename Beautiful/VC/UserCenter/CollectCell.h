//
//  CollectCell.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CollectCellDelegate <NSObject>

- (void)cancel:(UITableViewCell*)cell;
@end
@interface CollectCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UILabel* perPrice;
@property (nonatomic, strong) IBOutlet UIButton* collectBtn;
@property (nonatomic, strong) id<CollectCellDelegate>delegate;
+ (CollectCell*)getInstanceWithNib;
- (void)setUI:(CouponVO*)aVO;
@end
