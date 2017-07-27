//
//  AddressManageVC.m
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AddressManageVC.h"
#import "AddCell.h"
#import "PriceDayView.h"
#import "AddressDetialVC.h"
@interface AddressManageVC ()<AddCellDelegate,PriceDayViewDelegate>

@end

@implementation AddressManageVC

- (void)setUI
{
    self.title = @"地址管理";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    _addAry = [[NSMutableArray alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    [Utils cornerView:self.neBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //[self test];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAddress];
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
        else
        {
            
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 138;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"AddCell";
    AddCell *cell = (AddCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [AddCell getInstanceWithNib];
    }
    else{
        //NSLog(@"FixMentCell");
    }
    [cell setUI:self.addAry[row]];
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSInteger row = indexPath.row;
}

- (void)setDefault:(UITableViewCell*)cell
{
    NSIndexPath* index = [_tableView indexPathForCell:cell];
    AddressVO* aVO = _addAry[index.row];
    [[NetWork shareInstance] addressDefault:[Utils readUnarchiveHistoryGoodsVOsAry].token AddrId:aVO.addressId CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [[XQTipInfoView getInstanceWithNib] appear:@"设置成功"];
            for (AddressVO* aVO in _addAry) {
                if([_addAry indexOfObject:aVO] == index.row)
                    if([aVO.def isEqualToString:@"1"])
                        return;
                    else
                        aVO.def = @"1";
                    else
                        aVO.def = @"0";
            }
            [_tableView reloadData];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)edit:(UITableViewCell*)cells
{
    NSIndexPath* index = [_tableView indexPathForCell:cells];
    AddressDetialVC* vc = [[AddressDetialVC alloc] initWithNibName:@"AddressDetialVC" bundle:nil];
    vc.currentVO = self.addAry[index.row];
    vc.adType = 2;
    vc.title = @"编辑收货地址";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)del:(UITableViewCell*)cell
{
    NSIndexPath* index = [_tableView indexPathForCell:cell];
    [[PriceDayView getInstanceWithNib] appearWithTitle:@"确定删除？删除后不可恢复" Tip:@"提示" CommitTitle:@"确定" Delegate:self Row:index.row];
}

- (void)OKDayPress:(NSString *)nomalPrice Row:(NSInteger)row
{
    AddressVO* aVO = _addAry[row];
    [[NetWork shareInstance] addressDelete:[Utils readUnarchiveHistoryGoodsVOsAry].token AddrId:aVO.addressId CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [[XQTipInfoView getInstanceWithNib] appear:@"删除成功"];
            [self.addAry removeObjectAtIndex:row];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (IBAction)neAddress:(id)sender
{
    AddressDetialVC* vc = [[AddressDetialVC alloc] initWithNibName:@"AddressDetialVC" bundle:nil];
    //vc.currentVO = self.addAry[index.row];
    vc.adType = 1;
    vc.title = @"新建收货地址";
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
