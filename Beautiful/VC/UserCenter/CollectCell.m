//
//  CollectCell.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "CollectCell.h"

@implementation CollectCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CollectCell*)getInstanceWithNib
{
    CollectCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"CollectCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[CollectCell class]]){
            cell = (CollectCell *)obj;
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
}

- (IBAction)cancel:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(cancel:)])
        [_delegate cancel:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
