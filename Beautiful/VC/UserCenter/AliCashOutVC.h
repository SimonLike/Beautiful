//
//  AliCashOutVC.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AliCashOutVC : UIViewController
@property (nonatomic, strong) IBOutlet UScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UITextField* moneyText;
@property (nonatomic, strong) IBOutlet UITextField* countText;
@property (nonatomic, strong) IBOutlet UITextField* nameText;
@property (nonatomic, strong) IBOutlet UIButton* commitBtn;
@property (nonatomic, strong) IBOutlet UIView* bgView1;
@end
