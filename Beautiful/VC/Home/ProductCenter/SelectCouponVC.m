//
//  SelectCouponVC.m
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import "SelectCouponVC.h"
#import "CouponCell.h"
@interface SelectCouponVC ()

@end

@implementation SelectCouponVC

- (void)setUI
{
    self.title = @"选择代金券";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIButton* editBtn = [Utils createButtonWith:CustomButtonType_Text text:@"确定"];
    [editBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    _dataAry = [[NSMutableArray alloc] init];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    if([_couponID isEqualToString:@""])
    {
        CouponVO* cvo = [[CouponVO alloc] init];
        cvo.cashCouponId = @"";
        cvo.worth = @"";
        if(_couponBlock)
            _couponBlock(cvo);
    }
    else
    {
        for(CouponVO* vo in _dataAry)
        {
            if([vo.cashCouponId isEqualToString:_couponID])
            {  if(_couponBlock)
                {
                    _couponBlock(vo);
                    break;
                }
            }
        }

    }
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
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData
{
    [[NetWork shareInstance] CardList:[Utils readUnarchiveHistoryGoodsVOsAry].token CashCouponType:1 CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            NSArray *userArray = [CouponVO objectArrayWithKeyValuesArray:[info[@"data"] objectForKey:@"coupons"]];
            [self.dataAry addObjectsFromArray:userArray];
            for(CouponVO* vo in _dataAry)
            {
                if([vo.cashCouponId isEqualToString:_couponID])
                    vo.isSelected = @"YES";
            }
            [self.table reloadData];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
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
    return 114;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"CouponCell";
    CouponCell *cell = (CouponCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [CouponCell getInstanceWithNib];
    }
    else{
        //NSLog(@"FixMentCell");
    }
    CouponVO* vo = _dataAry[row];
    
    [cell setUI:vo];
    [cell setSelectMode];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CouponVO* vo = _dataAry[indexPath.row];
    if([vo.isSelected boolValue])
    {
        vo.isSelected = @"NO";
        [_table reloadData];
        _couponID = @"";
        return;
    }
    for(CouponVO* vo in _dataAry)
    {
        vo.isSelected = @"NO";
    }
    vo.isSelected = @"YES";
    _couponID = vo.cashCouponId;
    [_table reloadData];
    //NSInteger row = indexPath.row;
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
