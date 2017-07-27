//
//  CouponVC.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponVC : UIViewController
@property (nonatomic, strong) IBOutlet UITableView* table;
@property (nonatomic, strong) NSMutableArray* dataAry;
@property (nonatomic, strong) IBOutlet UIView* textBGView;
@property (nonatomic, strong) IBOutlet UITextField* cardText;
@end
