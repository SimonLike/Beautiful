//
//  OrderDetialCell.m
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderDetialCell.h"

@implementation OrderDetialCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderDetialCell*)getInstanceWithNib
{
    OrderDetialCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderDetialCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderDetialCell class]]){
            cell = (OrderDetialCell *)obj;
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
    _orderNo.text = [NSString stringWithFormat:@"订单编号：%@",oVO.orderNo];
    self.createTime.text = [NSString stringWithFormat:@"创建时间：%@",oVO.createTime];
    self.payTime.text = [NSString stringWithFormat:@"支付时间：%@",oVO.payTime];
    self.payType.text = [NSString stringWithFormat:@"支付方式：%@",[oVO.payType isEqualToString:@"alipay"]?@"支付宝":[oVO.payType isEqualToString:@"wx"]?@"微信支付":@"银联支付"];
    self.paySale.text = [NSString stringWithFormat:@"使用抵扣：%@",[oVO.cashCoupon isEqualToString:@""]?@"0.00":oVO.cashCoupon];
    _deliveryType.text = [NSString stringWithFormat:@"配送方式：%@",[oVO.deliveryType isEqualToString:@"0"]?@"快递":@"自提"];
    _getTime.text = [NSString stringWithFormat:@"收货时间：%@",oVO.receiveTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
