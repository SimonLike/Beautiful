//
//  MofifyPSWVC.m
//  Manage
//
//  Created by S on 15/12/22.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "MofifyPSWVC.h"

@interface MofifyPSWVC ()

@end

@implementation MofifyPSWVC

- (void)setUI
{
    self.title = @"修改密码";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [Utils cornerView:self.bgView2 withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.bgView1 withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.saveBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
}

- (IBAction)save:(id)sender
{
    if([_orgPWDText.text isEqualToString:@""])
    {
        TTAlert(@"请输入旧密码");
        return;
    }
    if([_nePWDText.text isEqualToString:@""]||[_configField.text isEqualToString:@""])
    {
        TTAlert(@"请输入新密码");
        return;
    }
    if(_orgPWDText.text.length<6||_nePWDText.text.length<6||_configField.text.length<6)
    {
        TTAlert(@"密码请设置为6-16位字母、字符、数字");
        return;
    }
    if(![_nePWDText.text isEqualToString:_configField.text])
    {
        TTAlert(@"新密码不一致，请重新输入");
        return;
    }
    [[NetWork shareInstance] modifyPSW:[Utils readUnarchiveHistoryGoodsVOsAry].token OldPassword:_orgPWDText.text NewPassword:_nePWDText.text CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [[XQTipInfoView getInstanceWithNib] appear:@"密码修改成功"];
            [self clickBack:nil];
        }
    } FailBack:^(NSError *error) {
        
    }];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.orgPWDText resignFirstResponder];
    [self.nePWDText resignFirstResponder];
    [self.configField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"%lu,%lu",(unsigned long)range.location,(unsigned long)range.length);
    //NSLog(@"%@",string);
    
    if(textField == self.orgPWDText)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.orgPWDText.text.length>=16&&range.length==0))
            return NO;
        else
            return YES;
    }
    else if(textField == self.nePWDText)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.nePWDText.text.length>=16&&range.length==0))
            return NO;
        else
            return YES;
    }
    else if(textField == self.configField)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.configField.text.length>=16&&range.length==0))
            return NO;
        else
            return YES;
    }
    else
        return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.orgPWDText resignFirstResponder];
    [self.nePWDText resignFirstResponder];
    [self.configField resignFirstResponder];
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
