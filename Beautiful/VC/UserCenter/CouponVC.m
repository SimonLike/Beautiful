//
//  CouponVC.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "CouponVC.h"
#import "CouponCell.h"
#import "CouponShareVC.h"
@interface CouponVC ()<CouponCellDelegate>
{
    UITapGestureRecognizer *tap;
    BOOL isGes;
}
@end

@implementation CouponVC


- (void)setUI
{
    self.title = @"我的卡券";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    _dataAry = [[NSMutableArray alloc] init];
    [Utils cornerView:_textBGView withRadius:20 borderWidth:0 borderColor:[UIColor clearColor]];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    isGes = NO;
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
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
    [[NetWork shareInstance] CardList:[Utils readUnarchiveHistoryGoodsVOsAry].token CashCouponType:0 CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [self.dataAry removeAllObjects];
            NSArray *userArray = [CouponVO objectArrayWithKeyValuesArray:[info[@"data"] objectForKey:@"coupons"]];
            [self.dataAry addObjectsFromArray:userArray];
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
    [cell setUI:self.dataAry[row]];
    cell.delegate = self;
    [cell setShareMode];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSInteger row = indexPath.row;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cardText resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(!isGes)
    {
        [self.table addGestureRecognizer:tap];
        isGes = !isGes;
    }
    return YES;
}

- (void)tap:(UIGestureRecognizer*)ges
{
    [self.cardText resignFirstResponder];
    if(isGes)
    {
        [self.table removeGestureRecognizer:ges];
        isGes = !isGes;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"%lu,%lu",(unsigned long)range.location,(unsigned long)range.length);
    //NSLog(@"%@",string);
    
    if(textField == self.cardText)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.cardText.text.length>=20&&range.length==0))
            return NO;
        else
            return YES;
    }
    else
        return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.cardText resignFirstResponder];
    if(isGes)
    {
        [self.table removeGestureRecognizer:tap];
        isGes = !isGes;
    }
    return YES;
}

- (IBAction)getNew:(id)sender
{
    //领取代金券
    [self.cardText resignFirstResponder];
    if(isGes)
    {
        [self.table removeGestureRecognizer:tap];
        isGes = !isGes;
    }
    if([_cardText.text isEqualToString:@""])
    {
        TTAlert(@"请输入抵用券分享码");
        return;
    }
    [[NetWork shareInstance] CouponGet:[Utils readUnarchiveHistoryGoodsVOsAry].token CouponNo:_cardText.text CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [[XQTipInfoView getInstanceWithNib] appear:@"领取成功"];
            [self getData];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)share:(UITableViewCell *)cell
{
    //分享代金券页面
    NSIndexPath* indexPath = [_table indexPathForCell:cell];
    CouponVO* cVO = _dataAry[indexPath.row];
    CouponShareVC* vc = [[CouponShareVC alloc] initWithNibName:@"CouponShareVC" bundle:nil];
    vc.cardID = cVO.couponNo;
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
