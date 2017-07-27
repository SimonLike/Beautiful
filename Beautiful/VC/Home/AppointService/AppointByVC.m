//
//  AppointByVC.m
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import "AppointByVC.h"
#import "OrderAddressCell.h"
#import "OrderItemCell.h"
#import "OrderItemTotalCell.h"
#import "OrderDeliveryCell.h"
#import "OrderCouponCell.h"
#import "OrderPayTypeCell.h"
#import "OrderFootView.h"
#import "SelectAddressVC.h"
#import "SelectCouponVC.h"

#import "AppDelegate.h"
#import "Pingpp.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@interface AppointByVC ()<OrderDeliveryCellDelegate,OrderPayTypeCellDelegate>
@end

@implementation AppointByVC

- (void)setUI
    {
        self.title = @"确认订单";
        [Utils setNavBarBgUI:self.navigationController.navigationBar];
        self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
        //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
        [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
        _totalPay.text = [NSString stringWithFormat:@"实付：￥%.2f",[_currentVO.totalPay floatValue]];
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
    return 5;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
        return 1;
        break;
        case 1:
        return 2;
        break;
        case 2:
        return 1;
        break;
        case 3:
        return 1;
        break;
        case 4:
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
    if(section == 4)
    {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH, 0)];
        label.numberOfLines = 999;
        label.font = [UIFont systemFontOfSize:14];
        NSString* str =@"交易须知：\n                                                       1、1次只能使用1张代金券，代金券金额必须低于订单总额\n2、配送方式选择后不可更换，如需更换请联系商家协调\n3、暂不支持在线退换货，如需退换货请联系商家协商\n4、支付后，15填内未确认收货，将自动确认";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:2];//调整行间距
        //[paragraphStyle setFirstLineHeadIndent:40];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        label.attributedText= attributedString;
        [label sizeToFit];
        float height = label.frame.size.height;
        return height+20;
    }
    //return 156;
    else
    return 8;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    if(section == 4)
    {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH, 0)];
        label.numberOfLines = 999;
        label.font = [UIFont systemFontOfSize:14];
        NSString* str =@"交易须知：\n                                                       1、1次只能使用1张代金券，代金券金额必须低于订单总额\n2、配送方式选择后不可更换，如需更换请联系商家协调\n3、暂不支持在线退换货，如需退换货请联系商家协商\n4、支付后，15填内未确认收货，将自动确认";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:2];//调整行间距
        //[paragraphStyle setFirstLineHeadIndent:40];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        label.attributedText= attributedString;
        [label sizeToFit];
        float height = label.frame.size.height;
        
        vv.frame = CGRectMake(0, 0, SCREEN_WIDTH, height+20);
        OrderFootView* view = [OrderFootView getInstanceWithNib];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, height+20);
        [view setHeight:str];
        [vv addSubview:view];
    }
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        return 86;
        break;
        case 1:
            if(indexPath.row == 1)
                return 40;
            else
                return 114;
        break;
        //        case 2:
        //            return 152;
        //            break;
        case 2:
            return 50;
        case 3:
        return 153;
        break;
        case 4:
        return 50;
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        break;
        case 1:
        {
            if(row == 1)
            {
                static NSString *cellIdentifier = @"OrderItemTotalCell";
                OrderItemTotalCell *cell = (OrderItemTotalCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [OrderItemTotalCell getInstanceWithNib];
                }
                
                [cell setUI:_currentVO];
                return cell;
            }
            else
            {
                static NSString *cellIdentifier = @"OrderItemCell";
                OrderItemCell *cell = (OrderItemCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [OrderItemCell getInstanceWithNib];
                }
                
                [cell setTUI:_currentVO.team];
                return cell;
            }
        }
        break;
        //        case 2:
        //        {
        //            static NSString *cellIdentifier = @"OrderDeliveryCell";
        //            OrderDeliveryCell *cell = (OrderDeliveryCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        //            if (cell == nil) {
        //                cell = [OrderDeliveryCell getInstanceWithNib];
        //            }
        //
        //            [cell setUI:_currentVO];
        //            cell.delegate = self;
        //            return cell;
        //        }
        //            break;
        case 2:
        {
            static NSString *cellIdentifier = @"Key";
            UITableViewCell *cell = [tableView   dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] init];
            }
            int leftTime = [_currentVO.team.leftTime intValue];
            int d = leftTime/60/60/24;
            int h = (leftTime%(60*60*24))/60*60;
            int m = (leftTime%(60*60))/60;
            int s = leftTime%60;
            
            
            
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-28, 55)];
            //UILabel* detialLabel;
            
            titleLabel.font = [UIFont systemFontOfSize:14.0];
            titleLabel.textColor = [UIColor blackColor];
            if(d!=0)
                titleLabel.text = [NSString stringWithFormat:@"还剩%i天%i小时%i分钟%i秒",d,h,m,s];
            else if(h!=0)
                titleLabel.text = [NSString stringWithFormat:@"还剩%i小时%i分钟%i秒",h,m,s];
            else if(m!=0)
                titleLabel.text = [NSString stringWithFormat:@"还剩%i分钟%i秒",m,s];
            else if(s!=0)
                titleLabel.text = [NSString stringWithFormat:@"还剩%i秒",s];
            [cell.contentView addSubview:titleLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 3:
        {
            static NSString *cellIdentifier = @"OrderPayTypeCell";
            OrderPayTypeCell *cell = (OrderPayTypeCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [OrderPayTypeCell getInstanceWithNib];
            }
            
            [cell setUI:_currentVO];
            cell.delegate = self;
            return cell;
        }
        break;
        case 4:
        {
            static NSString *cellIdentifier = @"OrderCouponCell";
            OrderCouponCell *cell = (OrderCouponCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [OrderCouponCell getInstanceWithNib];
            }
            
            [cell setUI:_currentVO];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        NSInteger section = indexPath.section;
        if(section == 0)
        {
            SelectAddressVC* vc = [[SelectAddressVC alloc] initWithNibName:@"SelectAddressVC" bundle:nil];
            vc.orderBlock = ^(AddressVO* vo)
            {
                _currentVO.name = vo.name;
                _currentVO.phone = vo.phone;
                _currentVO.address = [NSString stringWithFormat:@"%@%@%@%@",vo.province,vo.city,vo.county,vo.detail];
                [_table reloadData];
                _currentVO.addrId = vo.addressId;
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if(section == 3)
        {
            SelectCouponVC* vc = [[SelectCouponVC alloc] initWithNibName:@"SelectCouponVC" bundle:nil];
            vc.couponID = _currentVO.cashCouponID;
            vc.couponBlock = ^(CouponVO* vo)
            {
                _currentVO.cashCoupon = vo.worth;
                _currentVO.cashCouponID = vo.cashCouponId;
                
                _totalPay.text = [NSString stringWithFormat:@"实付：￥%.2f",[_currentVO.totalPrice floatValue]-[vo.worth floatValue]];
                [_table reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        //NSInteger row = indexPath.row;
    }
    
- (void)deliveryType:(NSString *)type
    {
        _currentVO.deliveryType = type;
    }
    
- (void)payType:(NSString *)type
    {
        _currentVO.payType = type;
    }
    
- (IBAction)commit:(id)sender
    {
        int tag = [_currentVO.payType intValue];
        if (tag == 0) {
            self.channel = @"alipay";
            //[self commit:nil];
        } else if (tag == 1) {
            self.channel = @"wx";
        } else if (tag == 2) {
            self.channel = @"upacp";
        }
        if([_currentVO.addrId isEqualToString:@""])
        {
            TTAlert(@"请选择收货地址");
            return;
        }
        [[NetWork shareInstance] PingPay:[Utils readUnarchiveHistoryGoodsVOsAry].token AddrId:_currentVO.addrId TeamId:_currentVO.team.teamProductId CashCouponId:_currentVO.cashCouponID PayType:self.channel CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                
                AppointByVC * __weak weakSelf = self;
                [Pingpp createPayment:info[@"data"] appURLScheme:@"wx1e0dd45abc8dd5fe" withCompletion:^(NSString *result, PingppError *error) {
                    NSLog(@"completion block: %@", result);
                    if (error == nil) {
                        NSLog(@"PingppError is nil");
                    } else {
                        NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                    }
                    if([result isEqualToString:@"success"])
                    {
                        [weakSelf showAlertMessage:@"支付成功"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                    else
                        [weakSelf showAlertMessage:@"支付失败"];
                }];
                
                
                
                
                
                
//                long long amount = [[@"2.00" stringByReplacingOccurrencesOfString:@"." withString:@""] longLongValue];
//                if (amount == 0) {
//                    return;
//                }
//                NSString *amountStr = [NSString stringWithFormat:@"%lld", amount];
//                
//                
//                NSDictionary* dict = @{
//                                       @"channel" : _channel,
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
//                AppointByVC * __weak weakSelf = self;
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
//                                [self.navigationController popToRootViewControllerAnimated:YES];
//                            }
//                            else
//                                [weakSelf showAlertMessage:@"支付失败"];
//                        }];
//                    });
//                }];

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
}

@end
