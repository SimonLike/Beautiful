//
//  AddCell.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddCellDelegate <NSObject>

- (void)setDefault:(UITableViewCell*)cell;
- (void)edit:(UITableViewCell*)cell;
- (void)del:(UITableViewCell*)cell;
@end
@interface AddCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* name;
@property (nonatomic, strong) IBOutlet UILabel* tel;
@property (nonatomic, strong) IBOutlet UILabel* address;
@property (nonatomic, strong) IBOutlet UIButton* defaultBtn;
@property (nonatomic, strong) id<AddCellDelegate>delegate;
+ (AddCell*)getInstanceWithNib;
- (void)setUI:(AddressVO*)aVO;
- (void)setDefault:(BOOL)isDefault;
@end
