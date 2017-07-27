//
//  MineHeaderCell.m
//  Manage
//
//  Created by S on 15/12/16.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "MineHeaderCell.h"

@implementation MineHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

+ (MineHeaderCell*)getInstanceWithNib
{
    MineHeaderCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[MineHeaderCell class]]){
            cell = (MineHeaderCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI
{
    [Utils cornerView:self.icon withRadius:40 borderWidth:0 borderColor:[UIColor whiteColor]];
    self.nameLabel.text = [Utils readUnarchiveHistoryGoodsVOsAry].username;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[Utils readUnarchiveHistoryGoodsVOsAry].iconUrl] placeholderImage:[UIImage imageNamed:@"defaulthead.png"]];
    
}

- (IBAction)backIction:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(back)])
        [_delegate back];
}

- (IBAction)userInfo:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(userInfo)])
        [_delegate userInfo];
}

- (IBAction)setting:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(setting)])
        [_delegate setting];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
