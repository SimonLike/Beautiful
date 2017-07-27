//
//  OrderItemCell.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderItemCell.h"

@implementation OrderItemCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderItemCell*)getInstanceWithNib
{
    OrderItemCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderItemCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderItemCell class]]){
            cell = (OrderItemCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(ProductVO*)aVO
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:aVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
    _title.text = aVO.title;
    _perPrice.text = [NSString stringWithFormat:@"￥%@",aVO.price];
    _buyNum.text = [NSString stringWithFormat:@"x%@",aVO.buyNum];
}

- (void)setTUI:(TeamVO*)aVO
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:aVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
    _title.text = aVO.title;
    _perPrice.text = [NSString stringWithFormat:@"￥%@",aVO.price];
    _buyNum.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
