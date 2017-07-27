//
//  OrderCouponCell.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderCouponCell.h"

@implementation OrderCouponCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderCouponCell*)getInstanceWithNib
{
    OrderCouponCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderCouponCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderCouponCell class]]){
            cell = (OrderCouponCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)setUI:(OrderVO*)vo
{
    _cashCoupon.text = vo.cashCoupon;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
