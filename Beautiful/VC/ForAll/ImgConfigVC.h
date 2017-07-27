//
//  ImgConfigVC.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthcodeView.h"
@interface ImgConfigVC : UIViewController
@property (nonatomic, strong) IBOutlet UITextField* userNameTextField;
@property (nonatomic, strong) IBOutlet UITextField* imgCodeTextField;
@property (nonatomic, strong) IBOutlet UIButton* loginBtn;
@property (nonatomic, strong) IBOutlet UIImageView* imgView;
@property (nonatomic, strong) IBOutlet UIImageView* imgBgView;
@property (nonatomic, strong) IBOutlet AuthcodeView* authCodeView;
@property (nonatomic, strong) NSString* imgType;
@end
