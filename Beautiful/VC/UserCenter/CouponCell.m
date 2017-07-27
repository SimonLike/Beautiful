//
//  CouponCell.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "CouponCell.h"

@implementation CouponCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CouponCell*)getInstanceWithNib
{
    CouponCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"CouponCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[CouponCell class]]){
            cell = (CouponCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(CouponVO*)aVO
{
    _statue = aVO.status;
    _couponID = aVO.cashCouponId;
    _money.text = [NSString stringWithFormat:@"￥%@",aVO.worth];
    _time.text = [NSString stringWithFormat:@"截止日期：%@",aVO.deadline];
    [Utils cornerView:_bgView withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    if([aVO.status isEqualToString:@"1"])
    {
        _status.text = @"未使用";
        _bgView.backgroundColor = [Utils colorWithHexString:@"38CD68"];
    }
    else if([aVO.status isEqualToString:@"2"])
    {
        _status.text = @"已使用";
        _bgView.backgroundColor = [Utils colorWithHexString:@"555555"];
    }
    else if([aVO.status isEqualToString:@"3"])
    {
        _status.text = @"已过期";
        _bgView.backgroundColor = [Utils colorWithHexString:@"888888"];
    }
    if([aVO.isSelected boolValue])
        self.selectIMG.image = PNG_FROM_NAME(@"select.png");
}

- (void)setSelectMode
{
    self.selectIMG.hidden = NO;
}

-  (void)setShareMode
{
    if([_statue isEqualToString:@"1"])
        self.shareBtn.hidden = NO;
}

- (IBAction)share:(id)sender
{
    if(_delegate&&[_delegate respondsToSelector:@selector(share:)])
        [_delegate share:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
