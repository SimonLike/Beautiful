//
//  ProductCell.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UILabel* perPrice;
@property (nonatomic, strong) IBOutlet UILabel* saleNum;
@property (nonatomic, strong) IBOutlet UIImageView* ticketIMG;
+ (ProductCell*)getInstanceWithNib;
- (void)setUI:(ProductVO*)aVO;
@end
