//
//  ProductDetialVC.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ProductDetialVC.h"
#import "AddsImageView.h"
#import "ShoppingCarVC.h"
#import "ProductByVC.h"
#import "LoginVC.h"
#import "NALNavigationController.h"
@interface ProductDetialVC ()
{
    int page;
}
@end

@implementation ProductDetialVC

- (void)setUI
{
    self.title = @"产品详情";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [Utils cornerView:_picNumBgView withRadius:20 borderWidth:0 borderColor:[UIColor clearColor]];
    [Utils cornerView:_shopCarBgView withRadius:10 borderWidth:0 borderColor:[UIColor clearColor]];
    page = 0;
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //[self addsTest];
    [self setDetial];
    // Do any additional setup after loading the view from its nib.
}

- (void)setDetial
{
    [self setADS:_currentVO.pics];
//    if([_currentVO.isDrawCoupon isEqualToString:@"1"])
//        _couponNumLabel.text = [NSString stringWithFormat:@"支付成功可获得%@抵用券",_currentVO.couponAmount];
//    else
//    {
//        CGRect rct = _infoView.frame;
//        rct.size.height = rct.size.height - 29;
//        _infoView.frame = rct;
//        rct = _webView.frame;
//        rct.origin.y = rct.origin.y - 29;
//        _webView.frame = rct;
    //}
    _picNum.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)_currentVO.pics.count];
    _titleLael.text = _currentVO.title;
    _perPrice.text = [NSString stringWithFormat:@"￥%@",_currentVO.price];
    _saleNum.text = [NSString stringWithFormat:@"已销售：%@",_currentVO.num];
//    if([_currentpVO.isCollected boolValue])
//        [_focusBtn setImage:PNG_FROM_NAME(@"fav.png") forState:UIControlStateNormal];
//    else
//        [_focusBtn setImage:PNG_FROM_NAME(@"fav_unselect.png") forState:UIControlStateNormal];
    _shopCarNum.text = @"5";
    [self.webView loadHTMLString:_currentVO.introduce baseURL:nil];
    self.webView.scrollView.scrollEnabled = NO;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
    p_progressHUD  = [[MBProgressHUD alloc] initWithView:self.view];
    p_progressHUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:p_progressHUD];
    [p_progressHUD show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
    NSLog(@"%f~%f",self.webView.scrollView.contentSize.width,self.webView.scrollView.contentSize.height);
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 365+self.webView.scrollView.contentSize.height)];
    CGRect rct = self.webView.frame;
    rct.size.height = self.webView.scrollView.contentSize.height;
    self.webView.frame = rct;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
}

- (void)addsTest
{
    NSString* picStr1 = @"default_marketing.png";
    NSString* picStr2 = @"default_marketing.png";
    NSString* picStr3 = @"default_marketing.png";
    NSArray* picArray = [NSArray arrayWithObjects:picStr1,picStr2,picStr3, nil];
    [self setADS:picArray];
    _picNum.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)_addsArray.count];
}

- (void)setADS:(NSArray*)array
{
    CGRect rct = self.picScrollVoew.bounds;
    rct.size.width = SCREEN_WIDTH;
    self.picScrollVoew.frame = rct;
    
    for (int m = 0; m<[[self.picScrollVoew subviews] count]; m++) {
        UIImageView* imgView = [[self.picScrollVoew subviews] objectAtIndex:m];
        [imgView removeFromSuperview];
    }
    int count = (int)[array count];
    int i;
    for ( i = 0; i<count; i++) {
        AddsImageView* imageView = [[AddsImageView alloc] init];
        
        //imageView.superDelegate = self;
        CGRect rct = self.picScrollVoew.frame;
        rct.origin.x = i*self.picScrollVoew.frame.size.width;
        rct.origin.y = 0;
        imageView.frame = rct;
        imageView.backgroundColor = [Utils colorWithHexString:@"e6e6e6"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        //[imageView addTap];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = rct;
        [btn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
        //imageView.image = [UIImage imageNamed:[array objectAtIndex:i]];
        [self.picScrollVoew addSubview:imageView];
        [self.picScrollVoew addSubview:btn];
    }
//    if([array count] != 0)
//    {
//        [_currentVO.pics removeAllObjects];
//        [_currentVO.pics addObjectsFromArray:array];
//    }
    //[UIImage imageNamed:@"hotelinfo_img_default.png"]
    [self.picScrollVoew setContentSize:CGSizeMake(i*self.picScrollVoew.frame.size.width, self.picScrollVoew.bounds.size.height)];
    [self.picScrollVoew setUp:count];
}

- (void)scan
{
    //加入图片浏览
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.picScrollVoew]) {
        page = scrollView.contentOffset.x / self.picScrollVoew.bounds.size.width;
        _picNum.text = [NSString stringWithFormat:@"%i/%lu",page+1,(unsigned long)_currentVO.pics.count];
    }
}

- (IBAction)shopCar:(id)sender
{
    //购物车
    if([Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
    {
        ShoppingCarVC* vc = [[ShoppingCarVC alloc] initWithNibName:@"ShoppingCarVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        LoginVC* loginViewController = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
        NALNavigationController *navVC = [[NALNavigationController alloc]initWithRootViewController:loginViewController];
        [Utils setNavBarBgUI:navVC.navigationBar];
        [self.navigationController presentViewController:navVC animated:YES completion:^{
            
        }];
    }
}

- (IBAction)focus:(id)sender
{
    if([Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
    {
        [[NetWork shareInstance] focus:[Utils readUnarchiveHistoryGoodsVOsAry].token ProductId:_currentVO.productId CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                [_focusBtn setImage:PNG_FROM_NAME(@"fav.png") forState:UIControlStateNormal];
                [[XQTipInfoView getInstanceWithNib] appear:@"已收藏"];

            }
        } FailBack:^(NSError *error) {
            
        }];
    }
    else
    {
        LoginVC* loginViewController = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
        NALNavigationController *navVC = [[NALNavigationController alloc]initWithRootViewController:loginViewController];
        [Utils setNavBarBgUI:navVC.navigationBar];
        [self.navigationController presentViewController:navVC animated:YES completion:^{
            
        }];
    }
}

- (IBAction)addToShopCar:(id)sender
{
    //添加到购物车
    if([Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
    {
        [[NetWork shareInstance] addToShopCar:[Utils readUnarchiveHistoryGoodsVOsAry].token ProductId:_currentVO.productId CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                [[XQTipInfoView getInstanceWithNib] appear:@"添加成功"];
            }
        } FailBack:^(NSError *error) {
            
        }];
    }
    else
    {
        LoginVC* loginViewController = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
        NALNavigationController *navVC = [[NALNavigationController alloc]initWithRootViewController:loginViewController];
        [Utils setNavBarBgUI:navVC.navigationBar];
        [self.navigationController presentViewController:navVC animated:YES completion:^{
            
        }];
    }
    
}

- (IBAction)byNow:(id)sender
{
    //这里创建订单基础
    if([Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
    {
        NSMutableArray* ary = [[NSMutableArray alloc] init];
        NSDictionary* dic = @{
                              @"cartId":@"",
                              @"productId":_currentVO.productId,
                              @"buyNum":[NSNumber numberWithInt:1],
                              };
        [ary addObject:dic];
        [[NetWork shareInstance] OrderCommit:[Utils readUnarchiveHistoryGoodsVOsAry].token Products:ary OrderNo:@"" CallBack:^(BOOL isSucc, NSDictionary *info) {
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
    else
    {
        LoginVC* loginViewController = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
        NALNavigationController *navVC = [[NALNavigationController alloc]initWithRootViewController:loginViewController];
        [Utils setNavBarBgUI:navVC.navigationBar];
        [self.navigationController presentViewController:navVC animated:YES completion:^{
            
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
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
