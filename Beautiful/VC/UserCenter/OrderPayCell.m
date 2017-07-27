//
//  OrderPayCell.m
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderPayCell.h"

@implementation OrderPayCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderPayCell*)getInstanceWithNib
{
    OrderPayCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderPayCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderPayCell class]]){
            cell = (OrderPayCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(OrderVO*)oVO
{
    if([oVO.orderType isEqualToString:@"0"])
        _status.text = @"待付款";
    else if([oVO.orderType isEqualToString:@"1"])
        _status.text = @"待发货";
    else if([oVO.orderType isEqualToString:@"2"])
        _status.text = @"待收货";
    else
    {
        _status.text = @"已完成";
        [_status setTextColor:[Utils colorWithHexString:@"38CD68"]];
    }
    _payLabel.text = [NSString stringWithFormat:@"共%lu件 实付：￥%@",(unsigned long)oVO.products.count,oVO.totalPrice];//这里这个字段有争议
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
