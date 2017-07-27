//
//  PingCell.h
//  Beautiful
//
//  Created by admin on 17/5/15.
//  Copyright © 2017年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UILabel* perPrice;
@property (nonatomic, strong) IBOutlet UILabel* saleNum;
@property (nonatomic, strong) IBOutlet UIImageView* ticketIMG;
+ (PingCell*)getInstanceWithNib;
- (void)setUI:(TeamVO*)aVO;
@end
