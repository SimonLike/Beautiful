//
//  MoneyCell.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "MoneyCell.h"

@implementation MoneyCell

- (void)awakeFromNib {
    // Initialization code
}

+ (MoneyCell*)getInstanceWithNib
{
    MoneyCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"MoneyCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[MoneyCell class]]){
            cell = (MoneyCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(MoneyVO*)aVO
{
    _time.text = aVO.time;
    _title.text = [aVO.type intValue] == 0?@"返现":@"提现";
    _content.text = aVO.desc;
    _money.text = aVO.amount;
    if([aVO.amount intValue] > 0)
        _money.textColor = [Utils colorWithHexString:@"FA6767"];
    else
        ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
