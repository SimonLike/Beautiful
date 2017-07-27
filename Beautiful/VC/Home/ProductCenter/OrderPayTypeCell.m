//
//  OrderPayTypeCell.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderPayTypeCell.h"

@implementation OrderPayTypeCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderPayTypeCell*)getInstanceWithNib
{
    OrderPayTypeCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderPayTypeCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderPayTypeCell class]]){
            cell = (OrderPayTypeCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(OrderVO*)vo
{
    if ([vo.payType isEqualToString:@"1"]) {
        _ali.image = PNG_FROM_NAME(@"unselect.png");
        _weiChat.image = PNG_FROM_NAME(@"select.png");
        _uni.image = PNG_FROM_NAME(@"unselect.png");
    }
    else if([vo.payType isEqualToString:@"2"])
    {
        _ali.image = PNG_FROM_NAME(@"unselect.png");
        _weiChat.image = PNG_FROM_NAME(@"unselect.png");
        _uni.image = PNG_FROM_NAME(@"select.png");
    }
    
}

- (IBAction)deliverySelect:(id)sender
{
    _ali.image = PNG_FROM_NAME(@"unselect.png");
    _weiChat.image = PNG_FROM_NAME(@"unselect.png");
    _uni.image = PNG_FROM_NAME(@"unselect.png");
    UIButton* btn = sender;
    switch (btn.tag) {
        case 100:
            _ali.image = PNG_FROM_NAME(@"select.png");
            
            if(_delegate&&[_delegate respondsToSelector:@selector(payType:)])
                [_delegate payType:@"0"];//支付宝
            break;
        case 200:
            _weiChat.image = PNG_FROM_NAME(@"select.png");
            if(_delegate&&[_delegate respondsToSelector:@selector(payType:)])
                [_delegate payType:@"1"];//微信
            break;
        case 300:
            _uni.image = PNG_FROM_NAME(@"select.png");
            if(_delegate&&[_delegate respondsToSelector:@selector(payType:)])
                [_delegate payType:@"2"];//银联
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
