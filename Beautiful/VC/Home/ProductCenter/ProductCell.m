//
//  ProductCell.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    // Initialization code
}

+ (ProductCell*)getInstanceWithNib
{
    ProductCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[ProductCell class]]){
            cell = (ProductCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)setUI:(ProductVO*)aVO
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:aVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
    _title.text = aVO.title;
    _perPrice.text = [NSString stringWithFormat:@"￥%@",aVO.price];
    _saleNum.text = [NSString stringWithFormat:@"已销售：%@",aVO.num];
    if([aVO.isDrawCoupon isEqualToString:@"1"])
        _ticketIMG.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
