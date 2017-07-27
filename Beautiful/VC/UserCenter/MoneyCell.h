//
//  MoneyCell.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UILabel* time;
@property (nonatomic, strong) IBOutlet UILabel* money;
@property (nonatomic, strong) IBOutlet UILabel* content;
+ (MoneyCell*)getInstanceWithNib;
- (void)setUI:(MoneyVO*)aVO;
@end
