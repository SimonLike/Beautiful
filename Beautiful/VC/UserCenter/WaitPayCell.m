//
//  WaitPayCell.m
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import "WaitPayCell.h"

@implementation WaitPayCell

- (void)awakeFromNib {
    // Initialization code
}

+ (WaitPayCell*)getInstanceWithNib
{
    WaitPayCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"WaitPayCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[WaitPayCell class]]){
            cell = (WaitPayCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(OrderVO*)oVO
{
    [Utils cornerView:_paybtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:_cancelBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    _status = oVO.orderType;
    if([oVO.orderType isEqualToString:@"0"])
        ;
    else
    {
        [_paybtn setTitle:@"确认收货" forState:UIControlStateNormal];
        _cancelBtn.hidden = YES;
    }
}

- (IBAction)commit:(id)sender
{
    if([_status isEqualToString:@"0"])
    {
        if(_delegate&&[_delegate respondsToSelector:@selector(payNow:)])
            [_delegate payNow:self];
    }
    else if ([_status isEqualToString:@"2"])
    {
        if(_delegate&&[_delegate respondsToSelector:@selector(getNow:)])
            [_delegate getNow:self];
    }
}

- (IBAction)cancel:(id)sender
{
    [[PriceDayView getInstanceWithNib] appearWithTitle:@"是否取消订单?" Tip:@"提示" CommitTitle:@"确定" Delegate:self Row:0];
}

- (void)OKDayPress:(NSString *)nomalPrice Row:(NSInteger)row
{
    if(_delegate&&[_delegate respondsToSelector:@selector(cancelNow:)])
        [_delegate cancelNow:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
