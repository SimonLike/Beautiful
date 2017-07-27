//
//  AppointTimeCell.h
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointTimeCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* timeLabel;
+ (AppointTimeCell*)getInstanceWithNib;
- (void)setUI:(NSString*)time;
@end
