//
//  OrderNumCell.m
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderNumCell.h"

@implementation OrderNumCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderNumCell*)getInstanceWithNib
{
    OrderNumCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderNumCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderNumCell class]]){
            cell = (OrderNumCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(OrderVO*)oVO
{
    _orderNum.text = [NSString stringWithFormat:@"订单编号：%@",oVO.orderNo];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
