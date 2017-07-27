//
//  OrderCenterVC.m
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderCenterVC.h"
#import "OrderNumCell.h"
#import "OrderPayCell.h"
#import "WaitPayCell.h"
#import "OrderItemCell.h"
#import "OrderDetialInfoVC.h"
#import "Pingpp.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "ProductByVC.h"
@interface OrderCenterVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,WaitPayCellDelegate>
{
    int page1;
    int pageSize1;
    BOOL haveNextPage1;
    int page2;
    int pageSize2;
    BOOL haveNextPage2;
    int page3;
    int pageSize3;
    BOOL haveNextPage3;
    int page4;
    int pageSize4;
    BOOL haveNextPage4;
}
@property (nonatomic, strong) UITableView* imTable;
@property (nonatomic, strong) UITableView* contactTable;
@property (nonatomic, strong) UITableView* fCircleTable;
@property (nonatomic, strong) UITableView* finishTable;
@end

@implementation OrderCenterVC

- (void)setUI
{
    self.title = @"我的订单";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.fCScrollView setClipsToBounds:YES];
    //rct.size.height = SCREEN_HEIGHT - 64;
    //self.fCScrollView.frame = rct;
    self.imTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStyleGrouped];
    self.imTable.backgroundColor = [UIColor clearColor];
    self.imTable.dataSource = self;
    //self.imTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.imTable.delegate = self;
    self.contactTable = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStyleGrouped];
    self.contactTable.backgroundColor = [UIColor clearColor];
    //self.contactTable.tintColor = [Utils colorWithHexString:@"e8e8e8"];
    //self.contactTable.sectionIndexBackgroundColor = [UIColor clearColor];
    //self.contactTable.sectionIndexColor = [Utils colorWithHexString:@"8e8e8e"];
    self.contactTable.dataSource = self;
    self.contactTable.delegate = self;
    //self.contactTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.fCircleTable = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStyleGrouped];;
    self.fCircleTable.backgroundColor = [UIColor clearColor];
    self.fCircleTable.dataSource = self;
    self.fCircleTable.delegate = self;
    //self.fCircleTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.finishTable = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStyleGrouped];;
    self.finishTable.backgroundColor = [UIColor clearColor];
    self.finishTable.dataSource = self;
    self.finishTable.delegate = self;
    
    
    [self.fCScrollView addSubview:self.imTable];
    [self.fCScrollView addSubview:self.contactTable];
    [self.fCScrollView addSubview:self.fCircleTable];
    [self.fCScrollView addSubview:self.finishTable];
    //[self.HKInfoScrollView addSubview:self.QuestionTable];
    [self.fCScrollView setShowsHorizontalScrollIndicator:NO];
    [self.fCScrollView setContentSize:CGSizeMake(SCREEN_WIDTH*4, 0)];
    
    self.orderType = Order_Wait;
    self.waitAry = [[NSMutableArray alloc] init];
    self.ingAry = [[NSMutableArray alloc] init];
    self.overAry = [[NSMutableArray alloc] init];
    self.finishAry = [[NSMutableArray alloc] init];
    page1 = 1;
    pageSize1 = 10;
    haveNextPage1 = YES;
    page2 = 1;
    pageSize2 = 10;
    haveNextPage2 = YES;
    page3 = 1;
    pageSize3 = 10;
    haveNextPage3 = YES;
    page4 = 1;
    pageSize4 = 10;
    haveNextPage4 = YES;
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [Utils setupRefresh:_imTable WithDelegate:self HeaderSelector:@selector(headerRefresh1) FooterSelector:@selector(footerRefresh1)];
    [Utils setupRefresh:_contactTable WithDelegate:self HeaderSelector:@selector(headerRefresh2) FooterSelector:@selector(footerRefresh2)];
    [Utils setupRefresh:_fCircleTable WithDelegate:self HeaderSelector:@selector(headerRefresh3) FooterSelector:@selector(footerRefresh3)];
    [Utils setupRefresh:_finishTable WithDelegate:self HeaderSelector:@selector(headerRefresh4) FooterSelector:@selector(footerRefresh4)];
    //[self getOrderData:page1];
    //[self test];
    // Do any additional setup after loading the view from its nib.
}

- (void)getOrderData:(int)Page
{
    [[NetWork shareInstance] OrderCenter:[Utils readUnarchiveHistoryGoodsVOsAry].token OrderType:_orderType Page:Page PageSize:10 CallBack:^(BOOL isSucc, NSDictionary *info) {
        
        switch (_orderType) {
            case Order_Wait:
                if(Page == 1)
                    [_imTable.mj_footer endRefreshing];
                [_imTable.mj_header endRefreshing];
                break;
            case Order_Ing:
                if(Page == 1)
                    [_contactTable.mj_footer endRefreshing];
                [_contactTable.mj_header endRefreshing];
                break;
            case Order_Over:
                if(Page == 1)
                    [_fCircleTable.mj_footer endRefreshing];
                [_fCircleTable.mj_header endRefreshing];
                break;
            case Order_Finish:
                if(Page == 1)
                    [_finishTable.mj_footer endRefreshing];
                [_finishTable.mj_header endRefreshing];
                break;
            default:
                break;
        }
        if(isSucc)
        {
            
            NSMutableArray *dataAry = [info[@"data"] objectForKey:@"orders"];
            NSArray* orderAry = [OrderVO objectArrayWithKeyValuesArray:dataAry];
            switch (_orderType) {
                case Order_Wait:
                    if(Page == 1)
                        [_waitAry removeAllObjects];
                    else
                        if(orderAry.count < 10)
                            [_imTable.mj_footer endRefreshingWithNoMoreData];
                    [_waitAry addObjectsFromArray:orderAry];
                    [_imTable reloadData];
                    break;
                case Order_Ing:
                    if(Page == 1)
                        [_ingAry removeAllObjects];
                    else
                        if(orderAry.count < 10)
                            [_contactTable.mj_footer endRefreshingWithNoMoreData];
                    [_ingAry addObjectsFromArray:orderAry];
                    [_contactTable reloadData];
                    break;
                case Order_Over:
                    if(Page == 1)
                        [_overAry removeAllObjects];
                    else
                        if(orderAry.count < 10)
                            [_fCircleTable.mj_footer endRefreshingWithNoMoreData];
                    [_overAry addObjectsFromArray:orderAry];
                    [_fCircleTable reloadData];
                    break;
                case Order_Finish:
                    if(Page == 1)
                        [_finishAry removeAllObjects];
                    else
                        if(orderAry.count < 10)
                            [_finishTable.mj_footer endRefreshingWithNoMoreData];
                    [_finishAry addObjectsFromArray:orderAry];
                    [_finishTable reloadData];
                    break;
                default:
                break;
            }

        }
    } FailBack:^(NSError *error) {
        switch (_orderType) {
            case Order_Wait:
                if(Page == 1)
                {
                    [_imTable.mj_footer endRefreshing];
                }
                else
                    [_imTable.mj_header endRefreshing];
                break;
            case Order_Ing:
                if(Page == 1)
                {
                    [_contactTable.mj_footer endRefreshing];
                }
                else
                    [_contactTable.mj_header endRefreshing];
                break;
            case Order_Over:
                if(Page == 1)
                {
                    [_fCircleTable.mj_footer endRefreshing];
                }
                else
                    [_fCircleTable.mj_header endRefreshing];
                break;
            case Order_Finish:
                if(Page == 1)
                {
                    [_finishTable.mj_footer endRefreshing];
                }
                else
                    [_finishTable.mj_header endRefreshing];
                break;
            default:
                break;
        }

    }];
}

- (void)headerRefresh1 {
    page1 = 1;
    [self getOrderData:page1];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        //[self.makTbale reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        //[self.makTbale headerEndRefreshing];
//        
//        
//        [_imTable.mj_header endRefreshing];
//        [_imTable.mj_footer endRefreshing];
//        
//    });
}

- (void)footerRefresh1 {
    page1 += 1;
    [self getOrderData:page1];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        //[self.makTbale reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        //[self.makTbale headerEndRefreshing];
//        [_imTable.mj_footer endRefreshingWithNoMoreData];
//    });
}

- (void)headerRefresh2 {
    page2 = 1;
    [self getOrderData:page2];
}

- (void)footerRefresh2 {
    page2 += 1;
    [self getOrderData:page2];
}
- (void)headerRefresh3 {
    page3 = 1;
    [self getOrderData:page3];
}

- (void)footerRefresh3 {
    page3 += 1;
    [self getOrderData:page3];
}
- (void)headerRefresh4 {
    page4 = 1;
    [self getOrderData:page4];
}

- (void)footerRefresh4 {
    page4 += 1;
    [self getOrderData:page4];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RESET_TABBAR object:[NSNumber numberWithBool:YES]];
    
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    //self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    
    switch (_orderType) {
        case Order_Wait:
            page1 = 1;
            [self getOrderData:page1];
            break;
        case Order_Ing:
            page2 = 1;
            [self getOrderData:page2];
            break;
        case Order_Over:
            page3 = 1;
            [self getOrderData:page3];
            break;
        case Order_Finish:
            page4 = 1;
            [self getOrderData:page4];
            break;
        default:
            break;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (IBAction)switchBtn:(id)sender
{
    UIButton* btn = sender;
    CGRect rct;
    //[self initTitleColor];
    switch (btn.tag) {
        case 900:
            [UIView beginAnimations:@"keybord" context:nil];
            [UIView setAnimationDuration:0.20];
            self.orderType = Order_Wait;
            rct = self.tipView.frame;
            rct.origin.x = (SCREEN_WIDTH/4-40)/2;
            self.tipView.frame = rct;
            [UIView commitAnimations];
            //self.waitingLabel.textColor = [Utils colorWithHexString:@"DD4F51"];
            [self.fCScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            if(_waitAry.count == 0)
            {
                page1 = 1;
                [self getOrderData:page1];
                [_imTable reloadData];
            }
            break;
        case 901:
            [UIView beginAnimations:@"keybord" context:nil];
            [UIView setAnimationDuration:0.20];
            self.orderType = Order_Ing;
            rct = self.tipView.frame;
            rct.origin.x = (SCREEN_WIDTH/4-40)/2+SCREEN_WIDTH/4;
            self.tipView.frame = rct;
            [UIView commitAnimations];
            //self.ingLabel.textColor = [Utils colorWithHexString:@"DD4F51"];
            [self.fCScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
            if(_ingAry.count == 0)
            {
                page2 = 1;
                [self getOrderData:page2];
                [_contactTable reloadData];
            }
            break;
        case 902:
            [UIView beginAnimations:@"keybord" context:nil];
            [UIView setAnimationDuration:0.20];
            self.orderType = Order_Over;
            rct = self.tipView.frame;
            rct.origin.x = (SCREEN_WIDTH/4-40)/2+SCREEN_WIDTH/4*2;
            self.tipView.frame = rct;
            [UIView commitAnimations];
            //self.overLabel.textColor = [Utils colorWithHexString:@"DD4F51"];
            [self.fCScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:YES];
            if(_overAry.count == 0)
            {
                page3 = 1;
                [self getOrderData:page3];
                [_fCircleTable reloadData];
            }
            break;
        case 903:
            [UIView beginAnimations:@"keybord" context:nil];
            [UIView setAnimationDuration:0.20];
            self.orderType = Order_Finish;
            rct = self.tipView.frame;
            rct.origin.x = (SCREEN_WIDTH/4-40)/2+SCREEN_WIDTH/4*3;
            self.tipView.frame = rct;
            [UIView commitAnimations];
            //self.overLabel.textColor = [Utils colorWithHexString:@"DD4F51"];
            [self.fCScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*3, 0) animated:YES];
            if(_finishAry.count == 0)
            {
                page4 = 1;
                [self getOrderData:page4];
                [_finishTable reloadData];
            }
            break;

        default:
            break;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.fCScrollView]) {
        int page = scrollView.contentOffset.x / self.fCScrollView.frame.size.width;
        CGRect rct;
        //[self initTitleColor];
        [UIView beginAnimations:@"keybord" context:nil];
        [UIView setAnimationDuration:0.20];
        switch (page) {
            case 0:
                self.orderType = Order_Wait;
                rct = self.tipView.frame;
                rct.origin.x = (SCREEN_WIDTH/4-40)/2;
                self.tipView.frame = rct;
                //self.waitingLabel.textColor = [Utils colorWithHexString:@"DD4F51"];
                if(_waitAry.count == 0)
                {
                    page1 = 1;
                    [self getOrderData:page1];
                    [_imTable reloadData];
                }
                break;
            case 1:
                self.orderType = Order_Ing;
                rct = self.tipView.frame;
                rct.origin.x = (SCREEN_WIDTH/4-40)/2+SCREEN_WIDTH/4;
                self.tipView.frame = rct;
                //self.ingLabel.textColor = [Utils colorWithHexString:@"DD4F51"];
                if(_ingAry.count == 0)
                {
                    page2 = 1;
                    [self getOrderData:page2];
                    [_contactTable reloadData];
                }
                break;
            case 2:
                self.orderType = Order_Over;
                rct = self.tipView.frame;
                rct.origin.x = (SCREEN_WIDTH/4-40)/2+SCREEN_WIDTH/4*2;
                self.tipView.frame = rct;
                //self.overLabel.textColor = [Utils colorWithHexString:@"DD4F51"];
                if(_overAry.count == 0)
                {
                    page3 = 1;
                    [self getOrderData:page3];
                    [_fCircleTable reloadData];
                }
                break;
            case 3:
                self.orderType = Order_Finish;
                rct = self.tipView.frame;
                rct.origin.x = (SCREEN_WIDTH/4-40)/2+SCREEN_WIDTH/4*3;
                self.tipView.frame = rct;
                //self.overLabel.textColor = [Utils colorWithHexString:@"DD4F51"];
                if(_finishAry.count == 0)
                {
                    page4 = 1;
                    [self getOrderData:page4];
                    [_finishTable reloadData];
                }
                break;
            default:
                break;
        }
        [UIView commitAnimations];
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    switch (self.orderType) {
        case Order_Wait:
            return self.waitAry.count;
            break;
        case Order_Ing:
            return self.ingAry.count;
            break;
        case Order_Over:
            return self.overAry.count;
            break;
        default:
            return self.finishAry.count;
            break;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(tableView == self.imTable)
    {
        OrderVO* oVO = _waitAry[section];
        return oVO.products.count+3;
        
    }
    else if(tableView == self.contactTable)
    {
        OrderVO* oVO = _ingAry[section];
        return oVO.products.count+2;
    }
    else if(tableView == self.fCircleTable)
    {
        OrderVO* oVO = _overAry[section];
        return oVO.products.count+3;
    }
    else
    {
        OrderVO* oVO = _finishAry[section];
        return oVO.products.count+2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
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
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;

    OrderVO* oVO;
    if(tableView == self.imTable)
    {
        oVO = _waitAry[section];
        
    }
    else if(tableView == self.contactTable)
    {
        oVO = _ingAry[section];
    }
    else if(tableView == self.fCircleTable)
    {
        oVO = _overAry[section];
    }
    else
    {
        oVO = _finishAry[section];
    }
    if(row == 0)
        return 40;
    else if(row <= oVO.products.count)
        return 114;
    else if(row == oVO.products.count+1)
        return 44;
    else
        return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    OrderVO* oVO;
    if(tableView == self.imTable)
    {
        oVO = _waitAry[section];
        
    }
    else if(tableView == self.contactTable)
    {
        oVO = _ingAry[section];
    }
    else if(tableView == self.fCircleTable)
    {
        oVO = _overAry[section];
    }
    else
    {
        oVO = _finishAry[section];
    }
    
    if(row == 0)
    {
        static NSString *cellIdentifier = @"OrderNumCell";
        OrderNumCell *cell = (OrderNumCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [OrderNumCell getInstanceWithNib];
        }
        else{
            //NSLog(@"FixMentCell");
        }
        [cell setUI:oVO];
         return cell;
    }
    else if(row <= oVO.products.count)
    {
        static NSString *cellIdentifier = @"OrderItemCell";
        OrderItemCell *cell = (OrderItemCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [OrderItemCell getInstanceWithNib];
        }
        else{
            //NSLog(@"FixMentCell");
        }
        [cell setUI:oVO.products[row-1]];
         return cell;
    }
    else if(row == oVO.products.count+1)
    {
        static NSString *cellIdentifier = @"OrderPayCell";
        OrderPayCell *cell = (OrderPayCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [OrderPayCell getInstanceWithNib];
        }
        else{
            //NSLog(@"FixMentCell");
        }
        [cell setUI:oVO];
         return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"WaitPayCell";
        WaitPayCell *cell = (WaitPayCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [WaitPayCell getInstanceWithNib];
        }
        else{
            //NSLog(@"FixMentCell");
        }
        [cell setUI:oVO];
        cell.delegate = self;
         return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    OrderDetialInfoVC* vc = [[OrderDetialInfoVC alloc] initWithNibName:@"OrderDetialInfoVC" bundle:nil];
    if(tableView == self.imTable)
    {
        vc.currentVO = _waitAry[section];
    }
    else if(tableView == self.contactTable)
    {
        vc.currentVO = _ingAry[section];
    }
    else if(tableView == self.fCircleTable)
    {
        vc.currentVO = _overAry[section];
    }
    else
    {
        vc.currentVO = _finishAry[section];
    }
    [self.navigationController pushViewController:vc animated:YES];
    //NSInteger row = indexPath.row;
}

- (void)payNow:(UITableViewCell*)cell
{
    NSIndexPath* index = [_imTable indexPathForCell:cell];
    OrderVO* oVO = [_waitAry objectAtIndex:index.section];
    ProductByVC* vc = [[ProductByVC alloc] initWithNibName:@"ProductByVC" bundle:nil];
    oVO.totalPay = oVO.totalPrice;
    vc.currentVO = oVO;
    [self.navigationController pushViewController:vc animated:YES];
//    NSMutableArray* ary = [[NSMutableArray alloc] init];
//    for (ProductVO*pVO in oVO.products) {
//        NSDictionary* dic = @{
//                              @"productId":pVO.productId,
//                              @"cartId":pVO.cartId,
//                              @"buyNum":[NSNumber numberWithInt:[pVO.buyNum intValue]],
//                              };
//        [ary addObject:dic];
//    }
//    [[NetWork shareInstance] OrderPay:[Utils readUnarchiveHistoryGoodsVOsAry].token AddrId:oVO.addrId Products:ary DeliveryType:oVO.deliveryType CashCouponId:oVO.cashCouponID PayType:oVO.payType orderNo:oVO.orderNo callBack:^(MKNetworkOperation *completedOperation) {
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//        //这里可能会加入错误码的判断
//        if (!error)
//        {
//            if([dic[@"status"] intValue] == 0)
//            {
//                long long amount = [[@"2.00" stringByReplacingOccurrencesOfString:@"." withString:@""] longLongValue];
//                if (amount == 0) {
//                    return;
//                }
//                NSString *amountStr = [NSString stringWithFormat:@"%lld", amount];
//                
//                
//                NSDictionary* dict = @{
//                                       @"channel" : oVO.payType,
//                                       @"amount"  : amountStr
//                                       };
//                NSURL* url = [NSURL URLWithString:@"http://218.244.151.190/demo/charge"];
//                NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];
//                NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//                NSString *bodyData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                
//                [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
//                [postRequest setHTTPMethod:@"POST"];
//                [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//                
//                OrderCenterVC * __weak weakSelf = self;
//                NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//                [self showAlertWait];
//                [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//                        [weakSelf hideAlert];
//                        if (httpResponse.statusCode != 200) {
//                            NSLog(@"statusCode=%ld error = %@", (long)httpResponse.statusCode, connectionError);
//                            [weakSelf showAlertMessage:@"网络错误"];
//                            return;
//                        }
//                        if (connectionError != nil) {
//                            NSLog(@"error = %@", connectionError);
//                            [weakSelf showAlertMessage:@"网络错误"];
//                            return;
//                        }
//                        NSString* charge = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                        NSLog(@"charge = %@", charge);
//                        [Pingpp createPayment:charge viewController:weakSelf appURLScheme:@"wxd930ea5d5a258f4f" withCompletion:^(NSString *result, PingppError *error) {
//                            NSLog(@"completion block: %@", result);
//                            if (error == nil) {
//                                NSLog(@"PingppError is nil");
//                            } else {
//                                NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
//                            }
//                            if([result isEqualToString:@"success"])
//                            {
//                                [weakSelf showAlertMessage:@"支付成功"];
//                                page1 = 1;
//                                [self getOrderData:page1];
//                                //[self.navigationController popToRootViewControllerAnimated:YES];
//                            }
//                            else
//                                [weakSelf showAlertMessage:@"支付失败"];
//                        }];
//                    });
//                }];
//                
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
//        [[XQTipInfoView getInstanceWithNib] appear:@"网络错误"];
//    }];

}

- (void)getNow:(UITableViewCell*)cell
{
    NSIndexPath* index = [_fCircleTable indexPathForCell:cell];
    OrderVO* oVO = [_overAry objectAtIndex:index.section];
    [[NetWork shareInstance] MakeSure:[Utils readUnarchiveHistoryGoodsVOsAry].token OrderNo:oVO.orderNo CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [[XQTipInfoView getInstanceWithNib] appear:@"操作成功"];
            page3 = 1;
            [self getOrderData:page3];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)cancelNow:(UITableViewCell*)cell
{
    NSIndexPath* index = [_imTable indexPathForCell:cell];
    OrderVO* oVO = [_waitAry objectAtIndex:index.section];
    [[NetWork shareInstance] CancelOrder:[Utils readUnarchiveHistoryGoodsVOsAry].token OrderNo:oVO.orderNo CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [[XQTipInfoView getInstanceWithNib] appear:@"取消成功"];
            page1 = 1;
            [self getOrderData:page1];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)showAlertWait
{
    mAlert = [[UIAlertView alloc] initWithTitle:@"正在获取支付凭据,请稍后..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [mAlert show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [mAlert addSubview:aiv];
}

- (void)showAlertMessage:(NSString*)msg
{
    mAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [mAlert show];
}

- (void)hideAlert
{
    if (mAlert != nil)
    {
        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
        mAlert = nil;
    }
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
