//
//  CashBackCell.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "CashBackCell.h"

@implementation CashBackCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CashBackCell*)getInstanceWithNib
{
    CashBackCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"CashBackCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[CashBackCell class]]){
            cell = (CashBackCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(CashBackVO*)aVO
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:aVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
    _title.text = aVO.productName;
    _perPrice.text = [NSString stringWithFormat:@"￥%@",aVO.productPrice];
    _saleNum.text = [NSString stringWithFormat:@"已销售：%@",aVO.productNum];
    _buyNum.text = aVO.sequence;
    if([aVO.money isEqualToString:@"0"]||[aVO.money isEqualToString:@""])
    {
        _backNum.textColor = [Utils colorWithHexString:@"666666"];
        _backNum.text = @"未获返现";
    }
    else
    {
        _backNum.textColor = [Utils colorWithHexString:@"188F61"];
        _backNum.text = [NSString stringWithFormat:@"已获返现：￥%@",aVO.money];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
