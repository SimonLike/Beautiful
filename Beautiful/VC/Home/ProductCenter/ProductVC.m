//
//  ProductVC.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ProductVC.h"
#import "ProductCell.h"
#import "ProductDetialVC.h"
#import "ProductCategoryVO.h"
#import "ProductSortVO.h"
#import "BGPopupView.h"
#import "CategoryChooseView.h"

@interface ProductVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, CategoryChooseViewDelegate>
{
    int page;
    int pageSize;
    UITableView* proTable;
    NSMutableArray* dataAry;
    NSArray *sortAry; // 排序列表
    ProductSortVO *sortModel;//排序模型
    NSMutableArray *categoryAry; // 分类列表
    ProductCategoryVO *categoryModel;// 分类模型
    
}
@end

@implementation ProductVC

- (void)setUI
{
    self.title = @"产品中心";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self setUpTable];
    [self getOrderData:page];
    [self getCategaryList];
    [self getSortList];
    
}

-(void)setUpData
{
    page = 1;
    pageSize = 10;
    dataAry = [NSMutableArray new];
    sortAry = [NSMutableArray new];
    categoryAry = [NSMutableArray new];
    categoryModel = [[ProductCategoryVO alloc] init];
    categoryModel.category = @"全部";
    categoryModel.categoryId = @"0";
    sortModel = [[ProductSortVO alloc] init];
    sortModel.sortId = @"1";
    sortModel.title = @"销量";
}


- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)LClick:(id)sender
{
    [BGPopupView hiddenPopView];
    CategoryChooseView *view = [CategoryChooseView buildCategoryChooseViewWithType:ChooseType_category modelAry:categoryAry];
    view.delegate = self;
    [BGPopupView showView:view frame:CGRectMake(0, 64+50, SCREEN_WIDTH, SCREEN_HEIGHT - 64-50) animationType:BGPopupAnimationTypeViewTop];
}

-(IBAction)Rclick:(id)sender
{
    [BGPopupView hiddenPopView];
    CategoryChooseView *view = [CategoryChooseView buildCategoryChooseViewWithType:ChooseType_sort modelAry:sortAry];
    view.delegate = self;
    [BGPopupView showView:view frame:CGRectMake(0, 64+50, SCREEN_WIDTH, SCREEN_HEIGHT - 64-50) animationType:BGPopupAnimationTypeViewTop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    [self setUI];
}

- (void)getOrderData:(int)Page
{
    int cID = [categoryModel.categoryId intValue];
    int zID = [sortModel.sortId intValue];
    
    [[NetWork shareInstance] productCenter:cID ZId:zID Page:page PageSize:pageSize CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            if(page == 1)
            {
                [proTable.mj_header endRefreshing];
                [proTable.mj_footer endRefreshing];
                [dataAry removeAllObjects];
            }
            NSArray* ary = [ProductVO objectArrayWithKeyValuesArray:info[@"data"][@"products"]];
            [proTable.mj_header endRefreshing];
            if(ary.count < pageSize)
                [proTable.mj_footer endRefreshingWithNoMoreData];
            else
                [proTable.mj_footer endRefreshing];
            [dataAry addObjectsFromArray:ary];
            [proTable reloadData];
        }
        else
        {
            [proTable.mj_header endRefreshing];
            [proTable.mj_footer endRefreshing];
        }
    } FailBack:^(NSError *error) {
        [proTable.mj_header endRefreshing];
        [proTable.mj_footer endRefreshing];
    }];
}

// 获取分类
-(void)getCategaryList
{
    [[NetWork shareInstance] Categary:^(BOOL isSucc, NSDictionary *info) {
        //
        if (isSucc)
        {
            [categoryAry removeAllObjects];
            NSArray* ary = [ProductCategoryVO objectArrayWithKeyValuesArray:info[@"data"][@"sorts"]];
            ProductCategoryVO *model = [[ProductCategoryVO alloc] init];
            model.category = @"全部";
            model.categoryId = @"0";
            [categoryAry addObject:model];
            [categoryAry addObjectsFromArray:ary];
        }
        
    } FailBack:^(NSError *error) {
        //
    }];
    
}

// 获取排序
-(void)getSortList
{
    ProductSortVO *model = [ProductSortVO new];
    model.title = @"销量";
    model.sortId = @"1";
    ProductSortVO *model1 = [ProductSortVO new];
    model1.title = @"价格最低";
    model1.sortId = @"2";
    ProductSortVO *model2 = [ProductSortVO new];
    model2.title = @"价格最高";
    model2.sortId = @"3";
    sortAry = @[model, model1, model2];
    
}



- (void)headRefresh {
    page = 1;
    [self getOrderData:page];
}

- (void)footRefresh {
    page += 1;
    [self getOrderData:page];
}

- (void)setUpTable
{
    proTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    proTable.frame = CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-64-50);
    proTable.backgroundColor = [UIColor clearColor];
    proTable.delegate = self;
    proTable.dataSource = self;
    //proTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [Utils setupRefresh:proTable WithDelegate:self HeaderSelector:@selector(headRefresh) FooterSelector:@selector(footRefresh)];
    [self.view addSubview:proTable];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataAry.count;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"ProductCell";
    ProductCell *cell = (ProductCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [ProductCell getInstanceWithNib];
    }
    else{
    }
    [cell setUI:dataAry[row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    ProductVO* pVo = dataAry[row];
    [[NetWork shareInstance] productDetial:pVo.productId CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            ProductDetialVO* vo = [ProductDetialVO objectWithKeyValues:info[@"data"]];
            ProductDetialVC* vc = [[ProductDetialVC alloc] initWithNibName:@"ProductDetialVC" bundle:nil];
            vc.currentVO = vo;
            vc.currentpVO = pVo;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CategoryChooseViewDelegate
-(void)CategoryChooseViewDidselectWithType:(ChooseType)type model:(id)model
{
    [BGPopupView hiddenPopView];
    if (type == ChooseType_category)
    {
        ProductCategoryVO *selectModel = (ProductCategoryVO *)model;
        categoryModel = selectModel;
        NSLog(@"category:%@,id:%@",selectModel.category,selectModel.categoryId);
    }
    else
    {
        ProductSortVO *selectModel = (ProductSortVO *)model;
        sortModel = selectModel;
        NSLog(@"sortTitle:%@,id:%@",selectModel.title,selectModel.sortId);
    }
    [self getOrderData:1];
    
}

@end
