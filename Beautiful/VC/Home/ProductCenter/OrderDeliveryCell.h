//
//  OrderDeliveryCell.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OrderDeliveryCellDelegate <NSObject>

- (void)deliveryType:(NSString*)type;

@end
@interface OrderDeliveryCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* yjImg;
@property (nonatomic, strong) IBOutlet UIImageView* arriveIMG;
@property (nonatomic, strong) id<OrderDeliveryCellDelegate>delegate;
+ (OrderDeliveryCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)vo;
@end
