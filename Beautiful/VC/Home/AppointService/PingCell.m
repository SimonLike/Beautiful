//
//  PingCell.m
//  Beautiful
//
//  Created by admin on 17/5/15.
//  Copyright © 2017年 B. All rights reserved.
//

#import "PingCell.h"

@implementation PingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (PingCell*)getInstanceWithNib
    {
        PingCell *cell = nil;
        NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"PingCell" owner:nil options:nil];
        for(id obj in objs) {
            if([obj isKindOfClass:[PingCell class]]){
                cell = (PingCell *)obj;
                break;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
    
- (void)setUI:(TeamVO*)aVO
{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:aVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
        _title.text = aVO.title;
        _perPrice.text = [NSString stringWithFormat:@"￥%@",aVO.price];
    int leftTime = [aVO.leftTime intValue];
    int d = leftTime/60/60/24;
    int h = (leftTime%(60*60*24))/60*60;
    int m = (leftTime%(60*60))/60;
    int s = leftTime%60;
    if(d!=0)
        _saleNum.text = [NSString stringWithFormat:@"还剩%i天%i小时%i分钟%i秒",d,h,m,s];
    else if(h!=0)
        _saleNum.text = [NSString stringWithFormat:@"还剩%i小时%i分钟%i秒",h,m,s];
    else if(m!=0)
        _saleNum.text = [NSString stringWithFormat:@"还剩%i分钟%i秒",m,s];
    else if(s!=0)
        _saleNum.text = [NSString stringWithFormat:@"还剩%i秒",s];
        _ticketIMG.hidden = YES;
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
