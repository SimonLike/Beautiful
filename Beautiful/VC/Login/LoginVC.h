//
//  LoginVC.h
//  Beautiful
//
//  Created by S on 16/1/25.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
@property (nonatomic, strong) IBOutlet UScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIButton* loginBtn;
@property (nonatomic, strong) IBOutlet UITextField* accountTxt;
@property (nonatomic, strong) IBOutlet UITextField* pswTxt;
@property (nonatomic, strong) IBOutlet UIView* firstView;
@end
