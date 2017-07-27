//
//  MineVC.m
//  Manage
//
//  Created by S on 15/12/16.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "MineVC.h"
#import "MineHeaderCell.h"
#import "MyInfoVC.h"
#import "SettingVC.h"
#import "AppointMentVC.h"
#import "PocketVC.h"
#import "CashBackVC.h"
#import "CouponVC.h"
#import "CollectVC.h"
#import "RecommendVC.h"
#import "OrderCenterVC.h"
@interface MineVC ()<MineHeaderDelegate>
{
    UILabel* orderNumLable;
}
@end

@implementation MineVC


- (void)setUI
{
    //self.title = @"营销活动";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Text text:nil];
    //[backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    orderNumLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-125-40, 1, 125, 55)];
    orderNumLable.textAlignment = NSTextAlignmentRight;
    orderNumLable.textColor = [Utils colorWithHexString:@"FA6767"];
    orderNumLable.font = [UIFont systemFontOfSize:12];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setting
{
    SettingVC* vc = [[SettingVC alloc] initWithNibName:@"SettingVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back
{
    [self clickBack:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RESET_TABBAR object:[NSNumber numberWithBool:NO]];
    self.navigationController.view.backgroundColor = RGBACOLOR(167, 163, 162, 1.0);
    
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.Minetable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    //[MobClick beginLogPageView:@"UserCenter"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    //[MobClick endLogPageView:@"UserCenter"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0)
                return 220;
            else
                return 56;
            break;
            
        default:
            return 56;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if(section == 0&&row == 0)
    {
        static NSString *cellIdentifier = @"MineHeaderCell";
        MineHeaderCell *cell = (MineHeaderCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [MineHeaderCell getInstanceWithNib];
        }
        else{
            //NSLog(@"FixMentCell");
        }
        [cell setUI];
        cell.delegate = self;
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"Key";
        UITableViewCell *cell = [tableView   dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] init];
        }
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 100, 55)];
        //UILabel* detialLabel;
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 26, 26)];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor blackColor];
        UIView* TopLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        TopLine.backgroundColor = [Utils colorWithHexString:@"dddddd"];
        
        UIView* bottowLine = [[UIView alloc] initWithFrame:CGRectMake(15, 55, SCREEN_WIDTH-15, 1)];
        bottowLine.backgroundColor = [Utils colorWithHexString:@"dddddd"];
//        detialLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 1, 125, 55)];
//        detialLabel.textAlignment = NSTextAlignmentRight;
//        detialLabel.textColor = [UIColor lightGrayColor];
//        detialLabel.font = [UIFont systemFontOfSize:13];
        switch (section)
        {
            case 0:
            {
                switch (row) {
                    case 1:
                    {
                        img.image = [UIImage imageNamed:@"nOrder4"];
                        titleLabel.text = @"我的订单";
                        //orderNumLable.text = @"3";
                        //[cell.contentView addSubview:orderNumLable];
                        //订单数量 暂时隐藏
                    }
                        break;
                    case 2:
                    {
                        img.image = [UIImage imageNamed:@"nOrder"];
                        titleLabel.text = @"我的拼团";
                        bottowLine.frame = CGRectMake(0, 55, SCREEN_WIDTH, 1);
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case 1:
            {
                switch (row) {
                    case 0:
                    {
                        img.image = [UIImage imageNamed:@"nOrder3"];
                        titleLabel.text = @"我的卡券";
                        [cell.contentView addSubview:TopLine];
                    }
                        break;
                    case 1:
                    {
                        img.image = [UIImage imageNamed:@"nOrder1"];
                        titleLabel.text = @"我的收藏";
                    }
                        break;
                    case 2:
                    {
                        img.image = [UIImage imageNamed:@"nOrder2"];
                        titleLabel.text = @"我的推荐";
                        bottowLine.frame = CGRectMake(0, 55, SCREEN_WIDTH, 1);
                    }
                        break;
                    default:
                        break;
                }
                

            }
                break;
            default:
                break;
            
        }
        [cell.contentView addSubview:img];
        [cell.contentView addSubview:titleLabel];
        [cell.contentView addSubview:bottowLine];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    id vc;
    switch (section) {
        case 0:
            switch (row)
            {
                case 0:
                    
                    break;
                case 1:
                    vc = [[OrderCenterVC alloc] initWithNibName:@"OrderCenterVC" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                case 2:
                    vc = [[AppointMentVC alloc] initWithNibName:@"AppointMentVC" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                default:
                    break;
            }
            
            break;
        case 1:
            switch (row)
        {
                case 0:
                vc = [[CouponVC alloc] initWithNibName:@"CouponVC" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                    break;
                case 1:
                    vc = [[CollectVC alloc] initWithNibName:@"CollectVC" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                case 2:
                    vc = [[RecommendVC alloc] initWithNibName:@"RecommendVC" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                default:
                    break;
        }
            break;
        default:
            break;
    }

    
    
    //加入选择事件
}
- (void)userInfo
{
    MyInfoVC* vc = [[MyInfoVC alloc] initWithNibName:@"MyInfoVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)OKDayPress:(NSString *)nomalPrice Row:(NSInteger)row
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSString* str = @"020-34548260";
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]];
    if(!telURL)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"电话号码有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    // 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationNone;
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
