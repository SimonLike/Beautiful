//
//  OrderAddressCell.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderAddressCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* name;
@property (nonatomic, strong) IBOutlet UILabel* phone;
@property (nonatomic, strong) IBOutlet UILabel* address;
@property (nonatomic, strong) IBOutlet UIImageView* addIMG;
@property (nonatomic, strong) IBOutlet UIImageView* contactIMG;
@property (nonatomic, strong) IBOutlet UILabel* tipLabel;
+ (OrderAddressCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)vo;
- (void)setAddressUI:(AddressVO*)vo;
@end
