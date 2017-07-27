//
//  SettingVC.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "SettingVC.h"
#import "SDImageCache.h"
#import "AboutVC.h"
#import "AppDelegate.h"
#import "AdviceVC.h"
@interface SettingVC ()
{
    UILabel* cacheLabel;
}
@end

@implementation SettingVC

- (void)setUI
{
    self.title = @"设置";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-125-40, 0, 125, 56)];
    cacheLabel.textAlignment = NSTextAlignmentRight;
    cacheLabel.textColor = [UIColor lightGrayColor];
    cacheLabel.font = [UIFont systemFontOfSize:12];
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
    //[self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    if(section == 0)
    {
        vv.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        UIButton* loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 50, SCREEN_WIDTH-30*2, 42)];
        loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [loginOutBtn setTitleColor:[Utils colorWithHexString:@"535353"] forState:UIControlStateNormal];
        loginOutBtn.backgroundColor = [Utils colorWithHexString:@"ffffff"];
        [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [loginOutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        [vv addSubview:loginOutBtn];
        [Utils cornerView:loginOutBtn withRadius:3 borderWidth:0.5 borderColor:[Utils colorWithHexString:@"eeeeee"]];
    }
    return vv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"Key";
    UITableViewCell *cell = [tableView   dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 56)];
    //UILabel* detialLabel;
    
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textColor = [Utils colorWithHexString:@"535353"];
    //UIView* TopLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    //TopLine.backgroundColor = [Utils colorWithHexString:@"dddddd"];
    
    //UIView* bottowLine = [[UIView alloc] initWithFrame:CGRectMake(15, 55, 305, 1)];
    //bottowLine.backgroundColor = [Utils colorWithHexString:@"dddddd"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    switch (row) {
        case 0:
        {
            titleLabel.text = @"关于软件";
        }
            break;
        case 1:
        {
            titleLabel.text = @"意见反馈";
        }
            break;
        case 2:
        {
            //img.image = [UIImage imageNamed:@"m_fitIcon.png"];
            titleLabel.text = @"清除缓存";
            cacheLabel.text = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache] getSize]/1024/1024/1024.];
            [cell.contentView addSubview:cacheLabel];
        }
            break;
        default:
            break;
    }
    [cell.contentView addSubview:titleLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    id vc;
    switch (row) {
        case 0:
        {
            vc = [[AboutVC alloc] initWithNibName:@"AboutVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            //detialLabel.text = uVO.name;
        }
            break;
        case 1:
        {
            vc = [[AdviceVC alloc] initWithNibName:@"AdviceVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            //img.image = [UIImage imageNamed:@"m_fitIcon.png"];
            
            //detialLabel.text = uVO.name;
        }
            break;
        case 2:
        {
            //img.image = [UIImage imageNamed:@"m_fitIcon.png"];
            [self clearCash:nil];
        }
            break;
        default:
            break;
    }
    //加入选择事件
}

- (IBAction)clearCash:(id)sender
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
    p_progressHUD  = [[MBProgressHUD alloc] initWithView:MyAppDelegate.window];
    p_progressHUD.mode = MBProgressHUDModeIndeterminate;
    [MyAppDelegate.window addSubview:p_progressHUD];
    [p_progressHUD show:YES];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        cacheLabel.text = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache] getSize]/1024/1024/1024.];
        [[XQTipInfoView getInstanceWithNib] appear:@"清理完毕"];
        p_progressHUD.hidden = YES;
        [p_progressHUD removeFromSuperview];
        p_progressHUD = nil;
    }];
    
}

- (void)loginOut
{
    
    [[NetWork shareInstance] loginOut:[Utils readUnarchiveHistoryGoodsVOsAry].token CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            //退出登录
            [[NSUserDefaults standardUserDefaults] setObject:LOGINOUT forKey:USER_LOGIN_STATUE];
            UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
            uVO.token = @"";
            uVO.iconUrl = @"";
            [Utils archiveHistoryGoodsVOsAry:uVO];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [(AppDelegate*)MyAppDelegate switchLoginStatus];
            [[XQTipInfoView getInstanceWithNib]appear:@"操作成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } FailBack:^(NSError *error) {
        
    }];
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
