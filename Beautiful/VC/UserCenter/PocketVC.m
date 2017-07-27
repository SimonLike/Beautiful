//
//  PocketVC.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "PocketVC.h"
#import "AliCashOutVC.h"
#import "UniCashOutVC.h"
#import "CashDetialVC.h"
@interface PocketVC ()

@end

@implementation PocketVC

- (void)setUI
{
    self.title = @"我的钱包";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back2 text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton* saveBtn = [Utils createButtonWith:CustomButtonType_Text2 text:nil];
    [saveBtn setTitle:@"钱包明细" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(myMoneyDetial:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [Utils cornerView:_aliCashOutBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:_uniCashOutBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    
    
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)myMoneyDetial:(id)sender
{
    CashDetialVC* vc = [[CashDetialVC alloc] initWithNibName:@"CashDetialVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RESET_TABBAR object:[NSNumber numberWithBool:YES]];
    
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    //self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    [self getData];
    //self.navigationController.view.backgroundColor = [Utils colorWithHexString:@"FA6767"];
}

- (void)getData
{
//    [[NetWork shareInstance] Money:[Utils readUnarchiveHistoryGoodsVOsAry].token callBack:^(MKNetworkOperation *completedOperation) {
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//        //这里可能会加入错误码的判断
//        if (!error)
//        {
//            if([dic[@"status"] intValue] == 0)
//            {
//                _moneyLabel.text = [NSString stringWithFormat:@"余额：￥%@",[dic[@"data"] objectForKey:@"balance"]];
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
//        
//    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //self.navigationController.navigationBar.hidden = NO;
    
}

- (IBAction)ali:(id)sender
{
    AliCashOutVC* vc = [[AliCashOutVC alloc] initWithNibName:@"AliCashOutVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)uni:(id)sender
{
    UniCashOutVC* vc = [[UniCashOutVC alloc] initWithNibName:@"UniCashOutVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
