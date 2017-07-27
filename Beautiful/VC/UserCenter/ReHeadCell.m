//
//  ReHeadCell.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ReHeadCell.h"

@implementation ReHeadCell

- (void)awakeFromNib {
    // Initialization code
}

+ (ReHeadCell*)getInstanceWithNib
{
    ReHeadCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"ReHeadCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[ReHeadCell class]]){
            cell = (ReHeadCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(NSString*)card
{
    _codeLabel.text = card;
}

- (IBAction)copyCode:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(copyCode)])
        [_delegate copyCode];

}

- (IBAction)weChat:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(weiChat)])
        [_delegate weiChat];
}

- (IBAction)weChatTimeLine:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(weiChatTimeLine)])
        [_delegate weiChatTimeLine];
}

- (IBAction)sina:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(sina)])
        [_delegate sina];
}

- (IBAction)QQ:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(QQ)])
        [_delegate QQ];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
