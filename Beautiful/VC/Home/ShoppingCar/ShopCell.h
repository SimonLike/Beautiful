//
//  ShopCell.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShopCellDelegate <NSObject>

- (void)plus:(UITableViewCell*)cell Num:(NSString*)num;
- (void)minus:(UITableViewCell*)cell Num:(NSString*)num;

@end

@interface ShopCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UILabel* perPrice;

@property (nonatomic, strong) IBOutlet UIButton* plusBtn;
@property (nonatomic, strong) IBOutlet UIButton* minusBtn;
@property (nonatomic, strong) IBOutlet UILabel* selectNum;
@property (nonatomic, strong) IBOutlet UIImageView* selectIMG;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) id<ShopCellDelegate>delegate;
@property (nonatomic, strong) ProductVO* currentVO;
- (void)setEditMode:(BOOL)isEdit;
+ (ShopCell*)getInstanceWithNib;
- (void)setUI:(ProductVO*)aVO;
- (void)setSelect:(BOOL)isSelect;
- (float)getShopMoney;
@end
