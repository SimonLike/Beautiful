//
//  UniCashOutVC.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "UniCashOutVC.h"
#import "CashOutSuccVC.h"
@interface UniCashOutVC ()

@end

@implementation UniCashOutVC

- (void)setUI
{
    self.title = @"银联提现";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [Utils cornerView:_commitBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:self.bgView1 withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //[self setNeedsStatusBarAppearanceUpdate];
    //[MobClick beginLogPageView:@"UserInfoCenter"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[MobClick endLogPageView:@"UserInfoCenter"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //if(![Utils readUnarchiveHistoryGoodsVOsAry])
    //    [self test];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)commit:(id)sender
{
    if([_moneyText.text isEqualToString:@""])
    {
        TTAlert(@"请输入提现金额");
        return;
    }
    if([_nameText.text isEqualToString:@""])
    {
        TTAlert(@"请输入持卡人姓名");
        return;
    }
    if([_cardText.text isEqualToString:@""]||_cardText.text.length<16)
    {
        TTAlert(@"请输入正确的卡号");
        return;
    }
    if([_countText.text isEqualToString:@""])
    {
        TTAlert(@"请输入银行名称");
        return;
    }
//    [[NetWork shareInstance] CashOut:[Utils readUnarchiveHistoryGoodsVOsAry].token DrawType:1 Amount:_moneyText.text Customer:_nameText.text Account:_cardText.text Bank:_countText.text callBack:^(MKNetworkOperation *completedOperation) {
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//        //这里可能会加入错误码的判断
//        if (!error)
//        {
//            if([dic[@"status"] intValue] == 0)
//            {
//                CashOutSuccVC* vc = [[CashOutSuccVC alloc] initWithNibName:@"CashOutSuccVC" bundle:nil];
//                [self.navigationController pushViewController:vc animated:YES];
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
//    }failBack:^(MKNetworkOperation *completedOperation) {
//        [[XQTipInfoView getInstanceWithNib] appear:@"网络错误"];
//    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.moneyText resignFirstResponder];
    [self.countText resignFirstResponder];
    [self.nameText resignFirstResponder];
    [self.cardText resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"%lu,%lu",(unsigned long)range.location,(unsigned long)range.length);
    //NSLog(@"%@",string);
    
    if(textField == self.moneyText)
    {
        if(([@"0123456789" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.moneyText.text.length>=20&&range.length==0))
            return NO;
        else
            return YES;
    }
    else if(textField == self.countText)
    {
        return YES;
    }
    else if(textField == self.nameText)
    {
        return YES;
    }
    else if(textField == self.cardText)
    {
        if(([@"0123456789" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.cardText.text.length>=19&&range.length==0))
            return NO;
        else
            return YES;
    }
    else
        return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.moneyText resignFirstResponder];
    [self.countText resignFirstResponder];
    [self.nameText resignFirstResponder];
    [self.cardText resignFirstResponder];
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
