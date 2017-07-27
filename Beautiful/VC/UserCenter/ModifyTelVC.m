//
//  ModifyTelVC.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ModifyTelVC.h"

@interface ModifyTelVC ()

@end

@implementation ModifyTelVC

- (void)setUI
{
    self.title = @"验证手机号";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [Utils cornerView:self.codeBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.bgView withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.saveBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
}

- (IBAction)save:(id)sender
{
    [[XQTipInfoView getInstanceWithNib] appear:@"保存成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [[NetWork shareInstance] modifyTel:[Utils readUnarchiveHistoryGoodsVOsAry].token Phone:_orgPWDText.text Code:_imgCodeTextField.text callBack:^(MKNetworkOperation *completedOperation) {
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//        //这里可能会加入错误码的判断
//        if (!error)
//        {
//            if([dic[@"status"] intValue] == 0)
//            {
//                UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
//                uVO.phone = _orgPWDText.text;
//                [Utils archiveHistoryGoodsVOsAry:uVO];
//                [[XQTipInfoView getInstanceWithNib] appear:@"保存成功"];
//                [self clickBack:nil];
//            }
//            else
//            {
//                [[XQTipInfoView getInstanceWithNib] appear:dic[@"msg"]];
//            }
//        }
//        else
//        {
//            [[XQTipInfoView getInstanceWithNib] appear:@"网络错误"];
//            
//        }
//    }];
    
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

- (IBAction)sendSMS:(id)sender
{
    [self.imgCodeTextField resignFirstResponder];
    if(!isTimer)
    {
        [[NetWork shareInstance] verifyCode:_telStr Type:@"2" CallBack:^(BOOL isSucc, NSDictionary *info) {
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
            else
            {
                
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.imgCodeTextField resignFirstResponder];
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
    else
        return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.imgCodeTextField resignFirstResponder];
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
