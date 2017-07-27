//
//  CollectVC.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "CollectVC.h"
#import "CollectCell.h"
#import "PriceDayView.h"
#import "ProductDetialVC.h"
@interface CollectVC ()<CollectCellDelegate>

@end

@implementation CollectVC

- (void)setUI
{
    self.title = @"我的收藏";
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
    [self getData];
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
    //[self test];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData
{
    [[NetWork shareInstance] MyFav:[Utils readUnarchiveHistoryGoodsVOsAry].token CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [_dataAry removeAllObjects];
            NSMutableArray *dataAry = [info[@"data"] objectForKey:@"products"];
            NSArray* orderAry = [ProductVO objectArrayWithKeyValuesArray:dataAry];
            [_dataAry addObjectsFromArray:orderAry];
            [_table reloadData];
        }
    } FailBack:^(NSError *error) {
        
    }];
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
                               @"perPrice" : @"300",
                               @"saleNum" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"60",
                               @"isCollected" : @"YES",
                               },
                           
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠法令纹除皱眼霜-重现眼部魅力法令纹除皱眼霜-重现眼部魅力）",
                               @"perPrice" : @"300",
                               @"saleNum" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"0",
                               @"isCollected" : @"YES",
                               },
                           
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠法令纹除皱眼霜-重现眼部魅力）",
                               @"perPrice" : @"300",
                               @"saleNum" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"10",
                               @"isCollected" : @"YES",
                               }
                           ];
    
    // 2.将字典数组转为User模型数组
    NSArray *userArray = [ProductVO objectArrayWithKeyValuesArray:dictArray];
    [self.dataAry addObjectsFromArray:userArray];
    [self.table reloadData];
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
    static NSString *cellIdentifier = @"CollectCell";
    CollectCell *cell = (CollectCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [CollectCell getInstanceWithNib];
    }
    else{
        //NSLog(@"FixMentCell");
    }
    [cell setUI:self.dataAry[row]];
    cell.delegate = self;
    //cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NetWork shareInstance] productDetial:((ProductVO*)_dataAry[indexPath.row]).productId CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            ProductDetialVO* vo = [ProductDetialVO objectWithKeyValues:info[@"data"]];
            ProductDetialVC* vc = [[ProductDetialVC alloc] initWithNibName:@"ProductDetialVC" bundle:nil];
            vc.currentVO = vo;
            vc.currentpVO = _dataAry[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)cancel:(UITableViewCell*)cell
{
    NSIndexPath* index = [_table indexPathForCell:cell];
    [[PriceDayView getInstanceWithNib] appearWithTitle:@"确定取消收藏?" Tip:@"提示" CommitTitle:@"确定" Delegate:self Row:index.row];
}

- (void)OKDayPress:(NSString *)nomalPrice Row:(NSInteger)row
{
    [[NetWork shareInstance] FavCancel:[Utils readUnarchiveHistoryGoodsVOsAry].token CollectionId:((ProductVO*)_dataAry[row]).collectionId CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [self.dataAry removeObjectAtIndex:row];
            [self.table beginUpdates];
            [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [self.table endUpdates];
            [[XQTipInfoView getInstanceWithNib] appear:@"已取消"];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
