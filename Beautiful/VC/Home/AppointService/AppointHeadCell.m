//
//  AppointHeadCell.m
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AppointHeadCell.h"

@implementation AppointHeadCell

- (void)awakeFromNib {
    // Initialization code
}

+ (AppointHeadCell*)getInstanceWithNib
{
    AppointHeadCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"AppointHeadCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[AppointHeadCell class]]){
            cell = (AppointHeadCell *)obj;
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
    _totalPrice.text = [NSString stringWithFormat:@"合计：￥%@",aVO.price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
