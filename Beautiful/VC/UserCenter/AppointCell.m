//
//  AppointCell.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AppointCell.h"

@implementation AppointCell

- (void)awakeFromNib {
    // Initialization code
}

+ (AppointCell*)getInstanceWithNib
{
    AppointCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"AppointCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[AppointCell class]]){
            cell = (AppointCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(AppointVO*)aVO
{
    self.orderNum.text = [NSString stringWithFormat:@"预约编号：%@",aVO.teamNo];
    self.titile.text = aVO.title;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:aVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
    self.money.text = [NSString stringWithFormat:@"￥%@",aVO.totalPrice];
    if([aVO.teamType isEqualToString:@"0"])
    {
        self.status.text = @"进行中";
        [self.status setTextColor:[Utils colorWithHexString:@"FA6767"]];
    }
    else
    {
        self.status.text = @"参与成功";
        [self.status setTextColor:[Utils colorWithHexString:@"208000"]];
    }
    self.payMoney.text = [NSString stringWithFormat:@"实付：￥%@",aVO.totalPay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
