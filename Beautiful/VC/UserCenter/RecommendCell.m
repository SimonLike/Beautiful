//
//  RecommendCell.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell

- (void)awakeFromNib {
    // Initialization code
}

+ (RecommendCell*)getInstanceWithNib
{
    RecommendCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"RecommendCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[RecommendCell class]]){
            cell = (RecommendCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(RecomVO*)vo;
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:vo.iconUrl] placeholderImage:[UIImage imageNamed:@"defaulthead.png"]];
    [Utils cornerView:_icon withRadius:15 borderWidth:0 borderColor:[UIColor clearColor]];
    _time.text = vo.registerTime;
    _comeFrom.text = @"注册";//vo.comeFrom;
    _name.text = vo.name;
    _money.text = [NSString stringWithFormat:@"获得代金券：￥%@",vo.amount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
