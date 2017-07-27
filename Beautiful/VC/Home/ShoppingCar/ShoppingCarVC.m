//
//  ShoppingCarVC.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ShoppingCarVC.h"
#import "ShopCell.h"
#import "PriceDayView.h"
#import "ProductByVC.h"
@interface ShoppingCarVC ()<ShopCellDelegate,PriceDayViewDelegate>
{
    UIButton* editBtn;
    BOOL isEdit;
    float totalMoney;
    BOOL isAll;
}
@end

@implementation ShoppingCarVC

- (void)setUI
{
    self.title = @"购物车";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    editBtn = [Utils createButtonWith:CustomButtonType_Text text:nil];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    _dataAry = [[NSMutableArray alloc] init];
    isEdit = NO;
    totalMoney = 0.00;
    isAll = NO;
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)edit:(id)sender
{
    //编辑
    isEdit = !isEdit;
    if (isEdit) {
        [editBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitle:@"删除" forState:UIControlStateNormal];
        _totalMoneyLabel.hidden = YES;
    }
    else
    {
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_finishBtn setTitle:@"结算" forState:UIControlStateNormal];
        _totalMoneyLabel.hidden = NO;
    }
    for (int i = 0; i<_dataAry.count; i++) {
        ShopCell* cell = (ShopCell*)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell setEditMode:isEdit];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)getData
{
    
    [[NetWork shareInstance] ShopCarList:[Utils readUnarchiveHistoryGoodsVOsAry].token CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            NSMutableArray *dataAry = [info[@"data"] objectForKey:@"carts"];
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
                               @"perPrice" : @"100",
                               @"saleNum" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"60",
                               @"isCollected" : @"YES",
                               @"selectNum" : @"2",
                               @"isSelected": @"NO",
                               
                               },
                           
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠法令纹除皱眼霜-重现眼部魅力法令纹除皱眼霜-重现眼部魅力）",
                               @"perPrice" : @"200",
                               @"saleNum" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"0",
                               @"isCollected" : @"NO",
                               @"selectNum" : @"1",
                               @"isSelected": @"NO",
                               },
                           
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠法令纹除皱眼霜-重现眼部魅力）",
                               @"perPrice" : @"300",
                               @"saleNum" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"10",
                               @"isCollected" : @"NO",
                               @"selectNum" : @"3",
                               @"isSelected": @"NO",
                               },
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠法令纹除皱眼霜-重现眼部魅力法令纹除皱眼霜-重现眼部魅力）",
                               @"perPrice" : @"200",
                               @"saleNum" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"0",
                               @"isCollected" : @"NO",
                               @"selectNum" : @"1",
                               @"isSelected": @"NO",
                               },
                           @{
                               @"icon" : @"",
                               @"title" : @"法令纹除皱眼霜-重现眼部魅力（新春活动价，更优惠法令纹除皱眼霜-重现眼部魅力）",
                               @"perPrice" : @"300",
                               @"saleNum" : @"200",
                               @"buyNum" : @"300",
                               @"cashBack" : @"10",
                               @"isCollected" : @"NO",
                               @"selectNum" : @"3",
                               @"isSelected": @"NO",
                               }
                           
                           ];
    
    // 2.将字典数组转为User模型数组
    NSArray *userArray = [ProductVO objectArrayWithKeyValuesArray:dictArray];
    [self.dataAry addObjectsFromArray:userArray];
//    for (ProductVO*pVO in _dataAry) {
//        if([pVO.isSelected boolValue])
//            totalMoney += [pVO.price floatValue]*[pVO.selectNum intValue];
//    }
//    NSLog(@"%.2f",totalMoney);
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
    static NSString *cellIdentifier = @"ShopCell";
    ShopCell *cell = (ShopCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [ShopCell getInstanceWithNib];
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
    ShopCell* cell = (ShopCell*)[tableView cellForRowAtIndexPath:indexPath];
    ProductVO* pVO = _dataAry[indexPath.row];
    if([pVO.isSelected boolValue])
    {
        pVO.isSelected = @"NO";
        [cell setSelect:NO];
        [self calculate:indexPath.row Plus:NO];
    }
    else
    {
        pVO.isSelected = @"YES";
        [cell setSelect:YES];
        [self calculate:indexPath.row Plus:YES];
    }
    BOOL all = YES;
    for (ProductVO*pVO in _dataAry) {
        if([pVO.isSelected boolValue])
            all = YES;
        else
        {
            all = NO;
            break;
        }
    }
    isAll = all;
    if(isAll)
        [_allBtn setImage:[UIImage imageNamed:@"login_yes.png"] forState:UIControlStateNormal];
    else
        [_allBtn setImage:[UIImage imageNamed:@"login_no.png"] forState:UIControlStateNormal];
}

- (IBAction)AllSelect:(id)sender
{
    isAll = !isAll;
    if(isAll)
        [_allBtn setImage:[UIImage imageNamed:@"login_yes.png"] forState:UIControlStateNormal];
    else
        [_allBtn setImage:[UIImage imageNamed:@"login_no.png"] forState:UIControlStateNormal];
    for (int i = 0; i<_dataAry.count; i++) {
        ShopCell* cell = (ShopCell*)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell setSelect:isAll];
        
    }
    for (ProductVO*pVO in _dataAry) {
        pVO.isSelected = isAll?@"YES":@"NO";
        if(isAll)
            totalMoney += [pVO.price floatValue]*[pVO.buyNum intValue];
        else
            totalMoney = 0.00;
    }//计算总价
    _totalMoneyLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",totalMoney];
    //此处做删除处理
}

- (IBAction)finishAction:(id)sender
{
    if(isEdit)
        [[PriceDayView getInstanceWithNib] appearWithTitle:@"是否删除已选物品?" Tip:@"提示" CommitTitle:@"确定" Delegate:self Row:0];
    else
    {
        //这里走付款流程，与产品中心结账一样
        //这里创建订单基础
        NSMutableArray* ary = [[NSMutableArray alloc] init];
        for (ProductVO*pVO in _dataAry) {
            if([pVO.isSelected boolValue])
            {
                NSDictionary* dic = @{
                                      @"cartId":pVO.cartId,
                                      @"productId":pVO.productId,
                                      @"buyNum":[NSNumber numberWithInt:[pVO.buyNum intValue]],
                                      };
                [ary addObject:dic];
            }
        }
        if(ary.count == 0)
        {
            TTAlert(@"请选择商品");
            return;
        }
        
        [[NetWork shareInstance] OrderCommit:[Utils readUnarchiveHistoryGoodsVOsAry].token Products:ary OrderNo:@""  CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                OrderVO* oVO = [OrderVO objectWithKeyValues:info[@"data"]];
                oVO.cashCoupon = @"";
                oVO.payType = @"0";
                oVO.deliveryType = @"0";
                oVO.totalPay = oVO.totalPrice;
                ProductByVC* vc = [[ProductByVC alloc] initWithNibName:@"ProductByVC" bundle:nil];
                vc.currentVO = oVO;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } FailBack:^(NSError *error) {
            
        }];
    }
}

- (void)OKDayPress:(NSString *)nomalPrice Row:(NSInteger)row
{
    NSMutableArray* delAry = [[NSMutableArray alloc] init];
    NSMutableArray* delObjAry = [[NSMutableArray alloc] init];
    NSMutableArray* delIdAry = [[NSMutableArray alloc] init];
    for (int i = 0; i<_dataAry.count; i++) {
        ProductVO* pVO = _dataAry[i];
        if([pVO.isSelected boolValue])
        {
            [delAry addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            [delObjAry addObject:pVO];
            [delIdAry addObject:pVO.cartId];
        }
    }
    
    [[NetWork shareInstance] ShopCarDelete:[Utils readUnarchiveHistoryGoodsVOsAry].token CartIds:delIdAry CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            for (ProductVO* pVO in delObjAry)
            {
                [_dataAry removeObject:pVO];
            }
            [self.table beginUpdates];
            [self.table deleteRowsAtIndexPaths:delAry withRowAnimation:UITableViewRowAnimationFade];
            [self.table endUpdates];
            totalMoney = 0.00;
            _totalMoneyLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",totalMoney];
            [[XQTipInfoView getInstanceWithNib] appear:@"删除成功"];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)plus:(UITableViewCell *)cell Num:(NSString *)num
{
    NSIndexPath* index = [_table indexPathForCell:cell];
    ProductVO* pVO = _dataAry[index.row];
    pVO.buyNum = num;
    if([pVO.isSelected boolValue])
    {
        float money = [pVO.price floatValue];
        totalMoney += money;
        NSLog(@"%.2f",totalMoney);
    }
    _totalMoneyLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",totalMoney];
}

- (void)minus:(UITableViewCell *)cell Num:(NSString *)num
{
    NSIndexPath* index = [_table indexPathForCell:cell];
    ProductVO* pVO = _dataAry[index.row];
    pVO.buyNum = num;
    if([pVO.isSelected boolValue])
    {
        float money = [pVO.price floatValue];
        totalMoney -= money;
        NSLog(@"%.2f",totalMoney);
    }
    _totalMoneyLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",totalMoney];
}

- (void)calculate:(NSInteger)index Plus:(BOOL)plus
{
    ProductVO* pVO = _dataAry[index];
    float money = [pVO.price floatValue]*[pVO.buyNum intValue];
    if(plus)
        totalMoney += money;
    else
        totalMoney -= money;
    _totalMoneyLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",totalMoney];
    //NSLog(@"%.2f",totalMoney);
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
