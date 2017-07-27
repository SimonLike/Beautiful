//
//  MofifyPSWVC.h
//  Manage
//
//  Created by S on 15/12/22.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MofifyPSWVC : UIViewController
@property (nonatomic, strong) IBOutlet UITextField* orgPWDText;
@property (nonatomic, strong) IBOutlet UITextField* nePWDText;
@property (nonatomic, strong) IBOutlet UIView* bgView1;
@property (nonatomic, strong) IBOutlet UIView* bgView2;
@property (nonatomic, strong) IBOutlet UITextField* configField;
@property (nonatomic, strong) IBOutlet UIButton* saveBtn;
@end
