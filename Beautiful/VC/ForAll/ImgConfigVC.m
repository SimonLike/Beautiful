//
//  ImgConfigVC.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ImgConfigVC.h"
#import "ModifyTelVC.h"
#import "RegistVC.h"

@interface ImgConfigVC ()

@end

@implementation ImgConfigVC

- (void)setUI
{
    //self.title = @"一键登录";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [Utils cornerView:self.imgBgView withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.loginBtn withRadius:5 borderWidth:0 borderColor:[UIColor clearColor]];
    if([self.imgType isEqualToString:@"3"])
        self.userNameTextField.placeholder = @"请输入新手机号";
    [_authCodeView getAuthcode];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self getImgCode:nil];
}

- (IBAction)getImgCode:(id)sender
{
//    [[NetWork shareInstance] verifyIMGCode:@"" callBack:^(MKNetworkOperation *completedOperation) {
//        UIImage* image = [UIImage imageWithData:[completedOperation responseData]];
//        self.imgView.image = image;
//    }];
}

- (IBAction)Next:(id)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.imgCodeTextField resignFirstResponder];
    if(self.userNameTextField.text.length != 11)
    {
        TTAlert(@"手机号输入有误");
        return;
    }
    if([self.imgCodeTextField.text isEqualToString:@""])
    {
        
        TTAlert(@"请输入验证码");
        return;
    }
    if(![[self.imgCodeTextField.text uppercaseString] isEqualToString:[_authCodeView.authCodeStr uppercaseString]])
    {
        
        TTAlert(@"验证码错误请重新输入");
        [_authCodeView getAuthcode];
        return;
    }
    if([self.imgType isEqualToString:@"0"])
    {
        RegistVC* vc = [[RegistVC alloc] initWithNibName:@"RegistVC" bundle:nil];
        vc.telStr = self.userNameTextField.text;
        vc.imgType = _imgType;
        vc.title = @"验证手机号";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([self.imgType isEqualToString:@"1"])
    {
        RegistVC* vc = [[RegistVC alloc] initWithNibName:@"RegistVC" bundle:nil];
        vc.telStr = self.userNameTextField.text;
        vc.imgType = _imgType;
        vc.title = @"重设密码";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        ModifyTelVC* vc = [[ModifyTelVC alloc] initWithNibName:@"ModifyTelVC" bundle:nil];
        vc.telStr = self.userNameTextField.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userNameTextField resignFirstResponder];
    [self.imgCodeTextField resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _imgCodeTextField&&[[_imgCodeTextField.text uppercaseString] isEqualToString:[_authCodeView.authCodeStr uppercaseString]])
    {
    }
    else if(textField == _imgCodeTextField)
    {
        //验证不匹配，验证码和输入框抖动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-10,@10,@-10];
        //        [authCodeView.layer addAnimation:anim forKey:nil];
        [_imgCodeTextField.layer addAnimation:anim forKey:nil];
        [[XQTipInfoView getInstanceWithNib] appear:@"验证码有误"];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userNameTextField resignFirstResponder];
    [self.imgCodeTextField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"%lu,%lu",(unsigned long)range.location,(unsigned long)range.length);
    //NSLog(@"%@",string);
    
    if(textField == self.userNameTextField)
    {
        if(([@"0123456789" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.userNameTextField.text.length>=11&&range.length==0))
            return NO;
        else
            return YES;
    }
    else if(textField == self.imgCodeTextField)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.imgCodeTextField.text.length>=4&&range.length==0))
            return NO;
        else
            return YES;
    }
    else
        return NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
