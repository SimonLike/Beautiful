//
//  AddCell.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AddCell.h"

@implementation AddCell

- (void)awakeFromNib {
    // Initialization code
}

+ (AddCell*)getInstanceWithNib
{
    AddCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"AddCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[AddCell class]]){
            cell = (AddCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(AddressVO*)aVO
{
    self.name.text = aVO.name;
    self.tel.text = aVO.phone;
    self.address.text = [NSString stringWithFormat:@"%@%@%@%@",aVO.province,aVO.city,aVO.county,aVO.detail];
    [self setDefault:[aVO.def isEqualToString:@"0"]?NO:YES];
}

- (void)setDefault:(BOOL)isDefault
{
    if(isDefault)
        [self.defaultBtn setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    else
        [self.defaultBtn setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
}

- (IBAction)setDefaultNow:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(setDefault:)])
        [_delegate setDefault:self];
}

- (IBAction)edit:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(edit:)])
        [_delegate edit:self];
}

- (IBAction)dele:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(del:)])
        [_delegate del:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
