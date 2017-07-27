//
//  OrderAddressCell.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderAddressCell.h"

@implementation OrderAddressCell

- (void)awakeFromNib {
    // Initialization code
}

+ (OrderAddressCell*)getInstanceWithNib
{
    OrderAddressCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderAddressCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderAddressCell class]]){
            cell = (OrderAddressCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)setUI:(OrderVO*)vo
{
    _name.text = vo.name;
    _phone.text = vo.phone;
    _address.text = vo.address;
    if([vo.name isEqualToString:@""])
    {
        _name.hidden = YES;
        _phone.hidden = YES;
        _address.hidden = YES;
        _addIMG.hidden = YES;
        _contactIMG.hidden = YES;
        _tipLabel.hidden = NO;
    }
    else
    {
        _name.hidden = NO;
        _phone.hidden = NO;
        _address.hidden = NO;
        _addIMG.hidden = NO;
        _contactIMG.hidden = NO;
        _tipLabel.hidden = YES;
    }
}

- (void)setAddressUI:(AddressVO*)vo
{
    _name.text = vo.name;
    _phone.text = vo.phone;
    _address.text = [NSString stringWithFormat:@"%@%@%@%@",vo.province,vo.city,vo.county,vo.detail];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
