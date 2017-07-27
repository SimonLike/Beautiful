//
//  AppointTimeCell.m
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AppointTimeCell.h"

@implementation AppointTimeCell

- (void)awakeFromNib {
    // Initialization code
}

+ (AppointTimeCell*)getInstanceWithNib
{
    AppointTimeCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"AppointTimeCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[AppointTimeCell class]]){
            cell = (AppointTimeCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(NSString*)time
{
    _timeLabel.text = time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
