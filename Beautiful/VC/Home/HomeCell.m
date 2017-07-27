//
//  HomeCell.m
//  Beautiful
//
//  Created by S on 16/1/25.
//  Copyright © 2016年 B. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

+ (HomeCell*)getInstanceWithNib{
    HomeCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[HomeCell class]]){
            cell = (HomeCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setUI:(RecommendVO*)rVO
{
    self.title.text = rVO.title;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:rVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
