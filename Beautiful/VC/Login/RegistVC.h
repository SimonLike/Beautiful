//
//  RegistVC.h
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistVC : UIViewController
{
    NSTimer * timer;
    BOOL isTimer;
    int timeCount;
}
@property (nonatomic, strong) NSString* imgType;
@property (nonatomic, strong) IBOutlet UScrollView* scrollView;
@property (nonatomic, strong) NSString* telStr;
@property (nonatomic, strong) IBOutlet UIButton* codeBtn;
@property (nonatomic, strong) IBOutlet UIView* bgView;
@property (nonatomic, strong) IBOutlet UITextField* imgCodeTextField;
@property (nonatomic, strong) IBOutlet UIButton* saveBtn;


@property (nonatomic, strong) IBOutlet UIButton* acceptBtn;
@property (nonatomic, strong) IBOutlet UIView* bgView2;
@property (nonatomic, strong) IBOutlet UIView* bgView3;
@property (nonatomic, strong) IBOutlet UITextField* pswText;
@property (nonatomic, strong) IBOutlet UITextField* pswConText;
@property (nonatomic, strong) IBOutlet UITextField* invitText;


@property (nonatomic, strong) IBOutlet UILabel* lable1;
@property (nonatomic, strong) IBOutlet UILabel* lable2;
@property (nonatomic, strong) IBOutlet UILabel* lable3;
@end
