//
//  OrderFootView.h
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderFootView : UIView
+ (OrderFootView*)getInstanceWithNib;
@property (nonatomic, strong) IBOutlet UILabel* tipLabel;
- (void)setHeight:(NSString*)tipStr;
@end
