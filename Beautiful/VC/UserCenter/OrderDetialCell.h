//
//  OrderDetialCell.h
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetialCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* orderNo;
@property (nonatomic, strong) IBOutlet UILabel* getTime;
@property (nonatomic, strong) IBOutlet UILabel* status;
@property (nonatomic, strong) IBOutlet UILabel* deliveryType;
@property (nonatomic, strong) IBOutlet UILabel* createTime;
@property (nonatomic, strong) IBOutlet UILabel* payTime;
@property (nonatomic, strong) IBOutlet UILabel* payType;
@property (nonatomic, strong) IBOutlet UILabel* paySale;
+ (OrderDetialCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)oVO;
@end
