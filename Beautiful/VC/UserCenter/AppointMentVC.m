//
//  AppointMentVC.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AppointMentVC.h"
#import "AppointCell.h"
#import "AppointDetialVC.h"
@interface AppointMentVC ()
{
    int page;
    int PageSize;
}
@end

@implementation AppointMentVC

- (void)setUI
{
    self.title = @"我的拼团";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    page = 1;
    PageSize = 10;
    self.dataAry = [[NSMutableArray alloc] init];
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
    [Utils setupRefresh:_table WithDelegate:self HeaderSelector:@selector(headerRefresh) FooterSelector:@selector(footerRefresh)];
    [self getOrderData:page];
    // Do any additional setup after loading the view from its nib.
}

- (void)getOrderData:(int)Page
{
    [[NetWork shareInstance] myTeamOrders:[Utils readUnarchiveHistoryGoodsVOsAry].token Page:page PageSize:10 CallBack:^(BOOL isSucc, NSDictionary *info) {
        if (isSucc)
        {
            if([info[@"status"] intValue] == 0)
            {
                if(Page == 1)
                {
                    [_dataAry removeAllObjects];
                    [_table.mj_header endRefreshing];
                }
                NSMutableArray *dataAry = [info[@"data"] objectForKey:@"orders"];
                for (NSDictionary *mDic in dataAry) {
                    AppointVO *model = [AppointVO objectWithKeyValues:mDic];
                    @try {
                        model.title = mDic[@"products"][0][@"title"];
                        model.pic = mDic[@"products"][0][@"pic"];
                    } @catch (NSException *exception) {
                        //
                    } @finally {
                        //
                    }
                    [_dataAry addObject:model];
                    
                }
                
                NSArray* orderAry = [AppointVO objectArrayWithKeyValuesArray:dataAry];
                if(orderAry.count < 10)
                    [_table.mj_footer endRefreshingWithNoMoreData];
                else
                    [_table.mj_footer endRefreshing];
//                [_dataAry addObjectsFromArray:orderAry];
                [_table reloadData];
            }
            else
            {
                [[XQTipInfoView getInstanceWithNib] appear:info[@"msg"]];
            }
        }
        else
        {
            [[XQTipInfoView getInstanceWithNib] appear:@"网络错误"];
            
        }

    } FailBack:^(NSError *error) {
        //
    }];
//    
//    [[NetWork shareInstance] MyService:[Utils readUnarchiveHistoryGoodsVOsAry].token Page:Page PageSize:10 callBack:^(MKNetworkOperation *completedOperation) {
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//        //这里可能会加入错误码的判断
//        
//        if (!error)
//        {
//            if([dic[@"status"] intValue] == 0)
//            {
//                if(Page == 1)
//                {
//                    [_dataAry removeAllObjects];
//                    [_table.mj_header endRefreshing];
//                }
//                NSMutableArray *dataAry = [dic[@"data"] objectForKey:@"services"];
//                NSArray* orderAry = [AppointVO objectArrayWithKeyValuesArray:dataAry];
//                if(orderAry.count < 10)
//                    [_table.mj_footer endRefreshingWithNoMoreData];
//                else
//                    [_table.mj_footer endRefreshing];
//                [_dataAry addObjectsFromArray:orderAry];
//                [_table reloadData];
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
//        
//    }];
}


- (void)headerRefresh {
    page = 1;
    [self getOrderData:page];
}

- (void)footerRefresh {
    page += 1;
    [self getOrderData:page];

}

- (void)test
{
    
//    @property (nonatomic, strong) NSString* title;
//    @property (nonatomic, strong) NSString* icon;
//    @property (nonatomic, strong) NSString* perPrice;
//    @property (nonatomic, strong) NSString* totalMoney;
//    @property (nonatomic, strong) NSString* payMoney;
//    @property (nonatomic, strong) NSString* appointTime;
//    @property (nonatomic, strong) NSString* status;//0.未消费 1.已消费
//    @property (nonatomic, strong) NSString* appointNum;
//    @property (nonatomic, strong) NSString* createTime;
//    @property (nonatomic, strong) NSString* payTime;
//    @property (nonatomic, strong) NSString* payType;//0.支付宝 1.微信 2.银联
//    @property (nonatomic, strong) NSString* paySale;
    NSArray *dictArray = @[
                           @{
                               @"title" : @"面部保湿套装（保湿霜+护肤精油，法国原装进口）",
                               @"icon" : @"",
                               @"perPrice" : @"300",
                               @"totalMoney" : @"300",
                               @"payMoney" : @"100",
                               @"appointTime" : @"2012-12-02 09:09",
                               @"status" : @"1",
                               @"appointNum" : @"123123123123123",
                               @"createTime" : @"2012-12-12 09:09",
                               @"payTime" : @"2012-12-12 09:09",
                               @"payType" : @"1",
                               @"paySale" : @"100",
                               },
                           
                           @{
                               @"title" : @"面部保湿套装（保湿霜+护肤精油，法国原装进口）面部保湿套装（保湿霜+护肤精油，法国原装进口）面部保湿套装（保湿霜+护肤精油，法国原装进口）",
                               @"icon" : @"",
                               @"perPrice" : @"300",
                               @"totalMoney" : @"300",
                               @"payMoney" : @"100",
                               @"appointTime" : @"2012-12-02 09:09",
                               @"status" : @"0",
                               @"appointNum" : @"123123123123123",
                               @"createTime" : @"2012-12-12 09:09",
                               @"payTime" : @"2012-12-12 09:09",
                               @"payType" : @"0",
                               @"paySale" : @"100",
                               },
                           
                           @{
                               @"title" : @"面部保湿套装（保湿霜+护肤精油，法国原装进口）面部保湿套装（保湿霜+护肤精油，法国原装进口）",
                               @"icon" : @"",
                               @"perPrice" : @"300",
                               @"totalMoney" : @"300",
                               @"payMoney" : @"100",
                               @"appointTime" : @"2012-12-02 09:09",
                               @"status" : @"0",
                               @"appointNum" : @"123123123123123",
                               @"createTime" : @"2012-12-12 09:09",
                               @"payTime" : @"2012-12-12 09:09",
                               @"payType" : @"2",
                               @"paySale" : @"100",
                               }
                           ];
    
    // 2.将字典数组转为User模型数组
    NSArray *userArray = [AppointVO objectArrayWithKeyValuesArray:dictArray];
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
    return self.dataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 172;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    static NSString *cellIdentifier = @"AppointCell";
    AppointCell *cell = (AppointCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [AppointCell getInstanceWithNib];
    }
    else{
        //NSLog(@"FixMentCell");
    }
    [cell setUI:self.dataAry[row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppointDetialVC* vc = [[AppointDetialVC alloc] initWithNibName:@"AppointDetialVC" bundle:nil];
    vc.currentVO = _dataAry[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    //加入选择事件
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
