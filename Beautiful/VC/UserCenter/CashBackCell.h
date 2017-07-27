//
//  CashBackCell.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashBackCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UILabel* perPrice;
@property (nonatomic, strong) IBOutlet UILabel* backNum;
@property (nonatomic, strong) IBOutlet UILabel* saleNum;
@property (nonatomic, strong) IBOutlet UILabel* buyNum;
+ (CashBackCell*)getInstanceWithNib;
- (void)setUI:(CashBackVO*)aVO;
@end
