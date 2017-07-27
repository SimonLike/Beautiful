//
//  OrderDetialInfoVC.m
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//
#import "OrderDetialInfoVC.h"
#import "OrderAddressCell.h"
#import "OrderItemCell.h"
#import "OrderItemTotalCell.h"
#import "OrderDetialCell.h"
#import "Pingpp.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "ProductByVC.h"
#import "PriceDayView.h"
@interface OrderDetialInfoVC ()<PriceDayViewDelegate>

@end

@implementation OrderDetialInfoVC

- (void)setUI
{
    self.title = @"订单详情";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [Utils cornerView:_paybtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:_cancelBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    
    if([_currentVO.orderType isEqualToString:@"0"])
        ;
    else
    {
        [_paybtn setTitle:@"确认收货" forState:UIControlStateNormal];
        _cancelBtn.hidden = YES;
    }
    if([_currentVO.orderType isEqualToString:@"0"]||[_currentVO.orderType isEqualToString:@"2"])
    {
        CGRect rct = _table.frame;
        rct.size.height = rct.size.height - 50;
        _table.frame = rct;
    }
    else
    {
        _payView.hidden = YES;
    }
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return _currentVO.products.count+1;
            break;
        case 2:
            return 1;
            break;
        default:
            return 1;
            break;
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
    switch (indexPath.section) {
        case 0:
            return 86;
            break;
        case 1:
            if(indexPath.row == _currentVO.products.count)
                return 40;
            else
                return 114;
            break;
        case 2:
            if([_currentVO.orderType isEqualToString:@"0"])
                return 88;
            else if([_currentVO.orderType isEqualToString:@"3"])
                return 218;
            else
                return 192;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case 0:
        {
            static NSString *cellIdentifier = @"OrderAddressCell";
            OrderAddressCell *cell = (OrderAddressCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [OrderAddressCell getInstanceWithNib];
            }
            
            [cell setUI:_currentVO];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 1:
        {
            if(row == _currentVO.products.count)
            {
                static NSString *cellIdentifier = @"OrderItemTotalCell";
                OrderItemTotalCell *cell = (OrderItemTotalCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [OrderItemTotalCell getInstanceWithNib];
                }
                if([_currentVO.orderType isEqualToString:@"0"])
                    [cell setUI:_currentVO];
                else
                    [cell setPayUI:_currentVO];
                return cell;
            }
            else
            {
                static NSString *cellIdentifier = @"OrderItemCell";
                OrderItemCell *cell = (OrderItemCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [OrderItemCell getInstanceWithNib];
                }
               [cell setUI:_currentVO.products[row]];
                return cell;
            }
        }
            break;
        case 2:
        {
            static NSString *cellIdentifier = @"OrderDetialCell";
            OrderDetialCell *cell = (OrderDetialCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [OrderDetialCell getInstanceWithNib];
            }
            
            [cell setUI:_currentVO];
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSInteger row = indexPath.row;
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

- (IBAction)commit:(id)sender
{
    if([_currentVO.orderType isEqualToString:@"0"])
    {
        //支付
        ProductByVC* vc = [[ProductByVC alloc] initWithNibName:@"ProductByVC" bundle:nil];
        _currentVO.totalPay = _currentVO.totalPrice;
        vc.currentVO = _currentVO;
        [self.navigationController pushViewController:vc animated:YES];
//        NSMutableArray* ary = [[NSMutableArray alloc] init];
//        for (ProductVO*pVO in _currentVO.products) {
//            NSDictionary* dic = @{
//                                  @"productId":pVO.productId,
//                                  @"cartId":pVO.cartId,
//                                  @"buyNum":[NSNumber numberWithInt:[pVO.buyNum intValue]],
//                                  };
//            [ary addObject:dic];
//        }
//        [[NetWork shareInstance] OrderPay:[Utils readUnarchiveHistoryGoodsVOsAry].token AddrId:_currentVO.addrId Products:ary DeliveryType:_currentVO.deliveryType CashCouponId:_currentVO.cashCouponID PayType:_currentVO.payType orderNo:_currentVO.orderNo callBack:^(MKNetworkOperation *completedOperation) {
//            NSError *error;
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//            //这里可能会加入错误码的判断
//            if (!error)
//            {
//                if([dic[@"status"] intValue] == 0)
//                {
//                    long long amount = [[@"2.00" stringByReplacingOccurrencesOfString:@"." withString:@""] longLongValue];
//                    if (amount == 0) {
//                        return;
//                    }
//                    NSString *amountStr = [NSString stringWithFormat:@"%lld", amount];
//                    
//                    
//                    NSDictionary* dict = @{
//                                           @"channel" : _currentVO.payType,
//                                           @"amount"  : amountStr
//                                           };
//                    NSURL* url = [NSURL URLWithString:@"http://218.244.151.190/demo/charge"];
//                    NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];
//                    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//                    NSString *bodyData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                    
//                    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
//                    [postRequest setHTTPMethod:@"POST"];
//                    [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//                    
//                    OrderDetialInfoVC * __weak weakSelf = self;
//                    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//                    [self showAlertWait];
//                    [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//                            [weakSelf hideAlert];
//                            if (httpResponse.statusCode != 200) {
//                                NSLog(@"statusCode=%ld error = %@", (long)httpResponse.statusCode, connectionError);
//                                [weakSelf showAlertMessage:@"网络错误"];
//                                return;
//                            }
//                            if (connectionError != nil) {
//                                NSLog(@"error = %@", connectionError);
//                                [weakSelf showAlertMessage:@"网络错误"];
//                                return;
//                            }
//                            NSString* charge = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                            NSLog(@"charge = %@", charge);
//                            [Pingpp createPayment:charge viewController:weakSelf appURLScheme:@"wxd930ea5d5a258f4f" withCompletion:^(NSString *result, PingppError *error) {
//                                NSLog(@"completion block: %@", result);
//                                if (error == nil) {
//                                    NSLog(@"PingppError is nil");
//                                } else {
//                                    NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
//                                }
//                                if([result isEqualToString:@"success"])
//                                {
//                                    [weakSelf showAlertMessage:@"支付成功"];
//                                    [self clickBack:nil];
//                                    //[self.navigationController popToRootViewControllerAnimated:YES];
//                                }
//                                else
//                                    [weakSelf showAlertMessage:@"支付失败"];
//                            }];
//                        });
//                    }];
//                    
//                }
//                else
//                {
//                    [[XQTipInfoView getInstanceWithNib] appear:dic[@"msg"]];
//                }
//            }
//            else
//            {
//                [[XQTipInfoView getInstanceWithNib] appear:@"网络错误"];
//                
//            }
//        }failBack:^(MKNetworkOperation *completedOperation) {
//            [[XQTipInfoView getInstanceWithNib] appear:@"网络错误"];
//        }];
        
        
    }
    else if ([_currentVO.orderType isEqualToString:@"2"])
    {
        //确认收货
        [[NetWork shareInstance] MakeSure:[Utils readUnarchiveHistoryGoodsVOsAry].token OrderNo:_currentVO.orderNo CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                [[XQTipInfoView getInstanceWithNib] appear:@"操作成功"];
                [self clickBack:nil];
            }
        } FailBack:^(NSError *error) {
            
        }];
    }
}

- (void)OKDayPress:(NSString *)nomalPrice Row:(NSInteger)row
{
    [[NetWork shareInstance] CancelOrder:[Utils readUnarchiveHistoryGoodsVOsAry].token OrderNo:_currentVO.orderNo CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [[XQTipInfoView getInstanceWithNib] appear:@"取消成功"];
            [self clickBack:nil];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (IBAction)cancel:(id)sender
{
    //取消订单
    [[PriceDayView getInstanceWithNib] appearWithTitle:@"是否取消订单?" Tip:@"提示" CommitTitle:@"确定" Delegate:self Row:0];
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
