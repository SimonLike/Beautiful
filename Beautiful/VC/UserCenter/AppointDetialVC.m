//
//  AppointDetialVC.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AppointDetialVC.h"

@interface AppointDetialVC ()

@end

@implementation AppointDetialVC

- (void)setUI
{
    self.title = @"拼团详情";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.appointNum.text = [NSString stringWithFormat:@"商品订单号：%@",_currentVO.teamNo];
    self.titleLabel.text = _currentVO.title;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_currentVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
    self.perPrice.text = [NSString stringWithFormat:@"￥%@",_currentVO.totalPrice];
    if([_currentVO.teamType isEqualToString:@"0"])
    {
        self.status.text = @"进行中";
        [self.status setTextColor:[Utils colorWithHexString:@"FA6767"]];
    }
    else
    {
        self.status.text = @"参与成功";
        [self.status setTextColor:[Utils colorWithHexString:@"208000"]];
    }
    self.payMoney.text = [NSString stringWithFormat:@"￥%@",_currentVO.totalPay];
    self.totalMoney.text = [NSString stringWithFormat:@"合计：￥%@ 实付：",_currentVO.totalPrice];
    self.appointTime.text = [NSString stringWithFormat:@"拼团剩余时间：%@",_currentVO.leftTime];
    self.createTime.text = [NSString stringWithFormat:@"创建时间：%@",_currentVO.createTime];
    self.payTime.text = [NSString stringWithFormat:@"支付时间：%@",_currentVO.payTime];
    //int payType = [_currentVO.payType intValue];
    self.payType.text = [NSString stringWithFormat:@"支付方式：%@",[_currentVO.payType isEqualToString:@"alipay"]?@"支付宝支付":[_currentVO.payType isEqualToString:@"wx"]?@"微信支付":@"银联支付"];
    self.paySale.text = [NSString stringWithFormat:@"使用抵扣：%@",[_currentVO.cashCoupon isEqualToString:@""]?@"0":_currentVO.cashCoupon];
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 480)];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = nil;
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
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
    // Do any additional setup after loading the view from its nib.
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
