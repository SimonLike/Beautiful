//
//  CashBackVC.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "CashBackVC.h"
#import "CashBackCell.h"
@interface CashBackVC ()

@end

@implementation CashBackVC

- (void)setUI
{
    self.title = @"我的返现";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    _dataAry = [[NSMutableArray alloc] init];
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
    [self getData];
    //if(![Utils readUnarchiveHistoryGoodsVOsAry])
    //[self test];
    // Do any additional setup after loading the view from its nib.
}

- (void)test
{
    
    
//    @property (nonatomic, strong) NSString* icon;
//    @property (nonatomic, strong) NSString* title;
//    @property (nonatomic, strong) NSString* perPrice;
//    @property (nonatomic, strong) NSString* saleNum;
//    @property (nonatomic, strong) NSString* buyNum;
//    @property (nonatomic, strong) NSString* cashBack;
//    @property (nonatomic, strong) NSString* isCollected;
    
    NSArray *dictArray = @[
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠）",
                               @"price" : @"300",
                               @"num" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"60",
                               @"isCollected" : @"YES",
                               },
                           
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠法令纹除皱眼霜-重现眼部魅力法令纹除皱眼霜-重现眼部魅力）",
                               @"price" : @"300",
                               @"num" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"0",
                               @"isCollected" : @"NO",
                               },
                           
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠法令纹除皱眼霜-重现眼部魅力）",
                               @"price" : @"300",
                               @"num" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"10",
                               @"isCollected" : @"NO",
                               }
                           ];
    
    // 2.将字典数组转为User模型数组
    NSArray *userArray = [ProductVO objectArrayWithKeyValuesArray:dictArray];
    [self.dataAry addObjectsFromArray:userArray];
    [self.table reloadData];
}

- (void)getData
{
//    [[NetWork shareInstance] CashBackList:[Utils readUnarchiveHistoryGoodsVOsAry].token callBack:^(MKNetworkOperation *completedOperation) {
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//        //这里可能会加入错误码的判断
//        if (!error)
//        {
//            if([dic[@"status"] intValue] == 0)
//            {
//                [self.dataAry removeAllObjects];
//                NSArray *userArray = [CashBackVO objectArrayWithKeyValuesArray:[dic[@"data"] objectForKey:@"backcash"]];
//                [self.dataAry addObjectsFromArray:userArray];
//                [self.table reloadData];
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
    static NSString *cellIdentifier = @"CashBackCell";
    CashBackCell *cell = (CashBackCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [CashBackCell getInstanceWithNib];
    }
    else{
        //NSLog(@"FixMentCell");
    }
    [cell setUI:self.dataAry[row]];
    //cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
