//
//  RecommendCell.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* name;
@property (nonatomic, strong) IBOutlet UILabel* time;
@property (nonatomic, strong) IBOutlet UILabel* comeFrom;
@property (nonatomic, strong) IBOutlet UILabel* money;
+ (RecommendCell*)getInstanceWithNib;
- (void)setUI:(RecomVO*)vo;
@end
