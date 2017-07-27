//
//  RegistVC.m
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()
{
    BOOL isAccept;
}
@end

@implementation RegistVC

- (void)setUI
{
    //self.title = @"验证手机号";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [Utils cornerView:self.codeBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.bgView withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.bgView2 withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.bgView3 withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.saveBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    if([_imgType isEqualToString:@"1"])
    {
        self.acceptBtn.hidden = YES;
        self.bgView3.hidden = YES;
        self.lable1.hidden = YES;
        self.lable2.hidden = YES;
        self.lable3.hidden = YES;
    }
    isAccept = YES;
}

- (IBAction)save:(id)sender
{
    if(!isAccept)
    {
        TTAlert(@"同意服务协议后才能注册");
        return;
    }
    if(_pswText.text.length<6||_pswText.text.length>16)
    {
        TTAlert(@"密码请设置为6-16位字母、字符、数字");
        return;
    }
    if(![_pswText.text isEqualToString:_pswConText.text])
    {
        TTAlert(@"两次输入密码不一致，请重新输入");
        return;
    }
    [self.imgCodeTextField resignFirstResponder];
    [self.pswConText resignFirstResponder];
    [self.pswText resignFirstResponder];
    [self.invitText resignFirstResponder];
    //[[XQTipInfoView getInstanceWithNib] appear:@"保存成功"];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    if([_imgType isEqualToString:@"0"])
    {
        [[NetWork shareInstance] regist:_telStr Password:_pswText.text Code:_imgCodeTextField.text InviteCode:_invitText.text CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                [[XQTipInfoView getInstanceWithNib] appear:@"注册成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } FailBack:^(NSError *error) {
            
        }];

    }
    else
    {
        [[NetWork shareInstance] findPSW:_telStr Password:_pswText.text Code:_imgCodeTextField.text CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                [[XQTipInfoView getInstanceWithNib] appear:@"密码重置成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } FailBack:^(NSError *error) {
            
        }];
    }
    
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

- (IBAction)accept:(id)sender
{
    [self.imgCodeTextField resignFirstResponder];
    [self.pswConText resignFirstResponder];
    [self.pswText resignFirstResponder];
    [self.invitText resignFirstResponder];
    isAccept = !isAccept;
    if(isAccept)
        [_acceptBtn setImage:PNG_FROM_NAME(@"select.png") forState:UIControlStateNormal];
    else
        [_acceptBtn setImage:PNG_FROM_NAME(@"unselect.png") forState:UIControlStateNormal];
}

- (IBAction)sendSMS:(id)sender
{
    [self.imgCodeTextField resignFirstResponder];
    [self.pswConText resignFirstResponder];
    [self.pswText resignFirstResponder];
    [self.invitText resignFirstResponder];
    if(!isTimer)
    {
        [[NetWork shareInstance] verifyCode:_telStr Type:_imgType CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                [[XQTipInfoView getInstanceWithNib] appear:@"验证码已发送"];
                timeCount = 60;
                isTimer = YES;
                self.codeBtn.titleLabel.text = [NSString stringWithFormat:@"重新获取(%i)",timeCount];
                [self.codeBtn setTitle:[NSString stringWithFormat:@"重新获取(%i)",timeCount] forState:UIControlStateNormal];
                self.codeBtn.backgroundColor = [Utils colorWithHexString:@"eeeeee"];
                [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(couter) userInfo:nil repeats:YES];
            }
        } FailBack:^(NSError *error) {
            
        }];
    }
    
}

- (void)couter
{
    if(timeCount > 0)
    {
        timeCount -= 1;
        self.codeBtn.titleLabel.text = [NSString stringWithFormat:@"重新获取(%i)",timeCount];
        [self.codeBtn setTitle:[NSString stringWithFormat:@"重新获取(%i)",timeCount] forState:UIControlStateNormal];
        self.codeBtn.enabled = NO;
    }
    else
    {
        isTimer = NO;
        [timer invalidate];
        timer = nil;
        self.codeBtn.enabled = YES;
        self.codeBtn.titleLabel.text = @"获取验证码";
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.backgroundColor = [Utils colorWithHexString:@"37CC66"];
        [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    if(textField == _invitText)
        [self.scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField == _invitText)
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.imgCodeTextField resignFirstResponder];
    [self.pswConText resignFirstResponder];
    [self.pswText resignFirstResponder];
    [self.invitText resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"%lu,%lu",(unsigned long)range.location,(unsigned long)range.length);
    //NSLog(@"%@",string);
    
    if(textField == self.imgCodeTextField)
    {
        if(([@"0123456789" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.imgCodeTextField.text.length>=6&&range.length==0))
            return NO;
        else
            return YES;
    }
    else if(textField == self.pswText)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.pswText.text.length>=16&&range.length==0))
            return NO;
        else
            return YES;
    }
    else if(textField == self.pswConText)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.pswConText.text.length>=16&&range.length==0))
            return NO;
        else
            return YES;
    }
    else if(textField == self.invitText)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.invitText.text.length>=20&&range.length==0))
            return NO;
        else
            return YES;
    }
    else
        return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.imgCodeTextField resignFirstResponder];
    [self.pswConText resignFirstResponder];
    [self.pswText resignFirstResponder];
    [self.invitText resignFirstResponder];
    return YES;
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
