//
//  ModifyTelVC.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyTelVC : UIViewController
{
    NSTimer * timer;
    BOOL isTimer;
    int timeCount;
}

@property (nonatomic, strong) IBOutlet UScrollView* scrollView;
@property (nonatomic, strong) NSString* telStr;
@property (nonatomic, strong) IBOutlet UIButton* codeBtn;
@property (nonatomic, strong) IBOutlet UIView* bgView;
@property (nonatomic, strong) IBOutlet UITextField* imgCodeTextField;
@property (nonatomic, strong) IBOutlet UIButton* saveBtn;
@end
