//
//  OrderItemTotalCell.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderItemTotalCell.h"

@implementation OrderItemTotalCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderItemTotalCell*)getInstanceWithNib
{
    OrderItemTotalCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderItemTotalCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderItemTotalCell class]]){
            cell = (OrderItemTotalCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(OrderVO*)vo
{
    _totalLabel.text = [NSString stringWithFormat:@"共%@件 合计：￥%@",vo.totalNum,vo.totalPrice];
}

- (void)setPayUI:(OrderVO*)vo
{
    _totalLabel.text = [NSString stringWithFormat:@"共%@件 合计：￥%@ 实付：￥%@",vo.totalNum,vo.totalPrice,vo.totalPay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
