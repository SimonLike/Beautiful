//
//  HomeCell.h
//  Beautiful
//
//  Created by S on 16/1/25.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UIImageView* icon;
+ (HomeCell*)getInstanceWithNib;
- (void)setUI:(RecommendVO*)rVO;
@end
