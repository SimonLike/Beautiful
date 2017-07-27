//
//  OrderDeliveryCell.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderDeliveryCell.h"

@implementation OrderDeliveryCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderDeliveryCell*)getInstanceWithNib
{
    OrderDeliveryCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderDeliveryCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderDeliveryCell class]]){
            cell = (OrderDeliveryCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(OrderVO*)vo
{
    if ([vo.deliveryType isEqualToString:@"1"]) {
        _yjImg.image = PNG_FROM_NAME(@"unselect.png");
        _arriveIMG.image = PNG_FROM_NAME(@"select.png");
    }
    
}

- (IBAction)deliverySelect:(id)sender
{
    UIButton* btn = sender;
    switch (btn.tag) {
        case 100:
            _yjImg.image = PNG_FROM_NAME(@"select.png");
            _arriveIMG.image = PNG_FROM_NAME(@"unselect.png");
            if(_delegate&&[_delegate respondsToSelector:@selector(deliveryType:)])
                [_delegate deliveryType:@"0"];
            break;
        case 200:
            _yjImg.image = PNG_FROM_NAME(@"unselect.png");
            _arriveIMG.image = PNG_FROM_NAME(@"select.png");
            if(_delegate&&[_delegate respondsToSelector:@selector(deliveryType:)])
                [_delegate deliveryType:@"1"];
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
