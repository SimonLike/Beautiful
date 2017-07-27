//
//  SelectAddressVC.m
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import "SelectAddressVC.h"
#import "OrderAddressCell.h"
#import "OrderAddressCell.h"
#import "AddressManageVC.h"
@interface SelectAddressVC ()

@end

@implementation SelectAddressVC

- (void)setUI
{
    self.title = @"选择收货地址";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton* editBtn = [Utils createButtonWith:CustomButtonType_Text text:@"管理"];
    [editBtn addTarget:self action:@selector(manage:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _addAry = [[NSMutableArray alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)manage:(id)sender
{
    AddressManageVC* vc = [[AddressManageVC alloc] initWithNibName:@"AddressManageVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //[self test];
    // Do any additional setup after loading the view from its nib.
}

- (void)getAddress
{
    [[NetWork shareInstance] addressGet:[Utils readUnarchiveHistoryGoodsVOsAry].token CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [self.addAry removeAllObjects];
            NSMutableArray* dataAry = [info[@"data"] objectForKey:@"address"];
            NSArray *addressAry = [AddressVO objectArrayWithKeyValuesArray:dataAry];
            [self.addAry addObjectsFromArray:addressAry];
            [self.tableView reloadData];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)test
{
    NSArray *dictArray = @[
                           @{
                               @"name" : @"张飞",
                               @"tel" : @"18628999519",
                               @"address" : @"四川成都阿加西啊西吧啊你哟卡机吗撒浪嘿哟,啊你哟卡机吗撒浪嘿哟",
                               @"area" : @"四川成都金牛区",
                               @"isDefault" : @"YES",
                               },
                           
                           @{
                               @"name" : @"张飞",
                               @"tel" : @"18628999519",
                               @"address" : @"四川成都阿加西啊西吧啊你哟卡机吗撒浪嘿哟",
                               @"area" : @"四川成都金牛区",
                               @"isDefault" : @"NO",
                               },
                           
                           @{
                               @"name" : @"张飞",
                               @"tel" : @"18628999519",
                               @"address" : @"四川成都阿加西啊西吧啊你哟卡机吗撒浪嘿哟",
                               @"area" : @"四川成都金牛区",
                               @"isDefault" : @"NO",
                               }
                           ];
    
    // 2.将字典数组转为User模型数组
    NSArray *userArray = [AddressVO objectArrayWithKeyValuesArray:dictArray];
    [self.addAry addObjectsFromArray:userArray];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _addAry.count;
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
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"AddCell";
    OrderAddressCell *cell = (OrderAddressCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [OrderAddressCell getInstanceWithNib];
    }
    else{
        //NSLog(@"FixMentCell");
    }
    [cell setAddressUI:self.addAry[row]];
    //cell.delegate = self;
    //cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(_orderBlock)
    {
        _orderBlock(_addAry[indexPath.row]);
    }
    [self clickBack:nil];
    //NSInteger row = indexPath.row;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAddress];
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
