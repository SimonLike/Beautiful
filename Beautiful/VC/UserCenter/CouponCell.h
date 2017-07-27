//
//  CouponCell.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CouponCellDelegate <NSObject>
- (void)share:(UITableViewCell*)cell;
@end
@interface CouponCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* money;
@property (nonatomic, strong) IBOutlet UILabel* time;
@property (nonatomic, strong) IBOutlet UILabel* status;
@property (nonatomic, strong) IBOutlet UIView* bgView;
@property (nonatomic, strong) IBOutlet UIImageView* selectIMG;
@property (nonatomic, strong) IBOutlet UIButton* shareBtn;
@property (nonatomic, strong) NSString* couponID;
@property (nonatomic, strong) id<CouponCellDelegate>delegate;
@property (nonatomic, strong) NSString* statue;
+ (CouponCell*)getInstanceWithNib;
- (void)setUI:(CouponVO*)aVO;
- (void)setSelectMode;
-  (void)setShareMode;
@end
