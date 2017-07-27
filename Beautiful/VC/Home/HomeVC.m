//
//  HomeVC.m
//  Beautiful
//
//  Created by S on 16/1/25.
//  Copyright © 2016年 B. All rights reserved.
//

#import "HomeVC.h"
#import "XNGuideView.h"
#import "AddsImageView.h"
#import "AddsWebViewController.h"
#import "XNAdvertisementView.h"
#import "HomeCell.h"
#import "MineVC.h"
#import "ScanVC.h"
#import "PriceDayView.h"
#import "ShoppingCarVC.h"
#import "ProductVC.h"
#import "AppointServiceVC.h"
#import "NALNavigationController.h"
#import "NALScanViewController.h"
#import "RecommendVC.h"
#import "CashBackVC.h"
#import "LoginVC.h"
@interface HomeVC ()<PriceDayViewDelegate>
{
    BOOL isExiststartpage;  //有广告图片存在时不显示HUD
    UIImageView* iconImg;
    NSString* acStr;
    SystemSoundID      p_shakeSoundID;
    BOOL firstLauch;
}
@end

@implementation HomeVC

- (void)setUI
{
    self.title = @"鹏城购";
    //[self initLoadView];广告页
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIButton* UserBtn = [Utils createButtonWith:CustomButtonType_UserCenter text:nil];
    [UserBtn addTarget:self action:@selector(goToUser) forControlEvents:UIControlEventTouchUpInside];
    iconImg = [[UIImageView alloc] initWithFrame:UserBtn.bounds];
    [UserBtn addSubview:iconImg];
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[Utils readUnarchiveHistoryGoodsVOsAry].iconUrl] placeholderImage:[UIImage imageNamed:@"defaulthead.png"]];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:UserBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //[iconImg sd_setImageWithURL:[NSURL URLWithString:[Utils readUnarchiveHistoryGoodsVOsAry].iconUrl] placeholderImage:[UIImage imageNamed:@"h_User_press.png"]];
    
    //UIButton* searchBtn = [Utils createButtonWith:CustomButtonType_Share text:@""];
    //[searchBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    if([[Utils readUnarchiveHistoryGoodsVOsAry].role isEqualToString:@"1"])
//    {
//        [searchBtn setImage:[UIImage imageNamed:@"h_Info.png"] forState:UIControlStateNormal];
//        [searchBtn setImage:[UIImage imageNamed:@"h_Info_Press.png"] forState:UIControlStateHighlighted];
//        self.fitLabel.text = @"装修单";
//        self.fixLabel.text = @"报修单";
//    }
    //UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    //self.navigationItem.rightBarButtonItem = rightItem;
    self.addsArray = [[NSMutableArray alloc] init];
    self.recomandAry = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [Utils colorWithHexString:@"f7f7f7"];
    
    //[self initGuideView];
    firstLauch = YES;
}

//Guide
- (void)initGuideView {
    NSString *picsizeStr = nil;
    //    switch ((int)SCREEN_WIDTH) {
    //        case 320: //3/4/5
    //            picsizeStr = ((int)SCREEN_HEIGHT == 480) ? @"_640960" : @"_6401136";
    //            break;
    //
    //        case 375:{ //6
    //            picsizeStr = @"_7501334";
    //        }
    //            break;
    //
    //        case 414: //6P
    //            picsizeStr = @"_12422208";
    //            break;
    //
    //        default:
    //            picsizeStr = @"_7501334";
    //            break;
    //    }
    
    switch ((int)SCREEN_HEIGHT) {
        case 480: //3/4/5
            picsizeStr = @"_640960";
            break;
        default:
            picsizeStr = @"_6401136";
            break;
    }
    
    NSMutableArray *picnames = [[NSMutableArray alloc] init];
    for(int i=1; i<=3; i++) {
        NSString *pic = [NSString stringWithFormat:@"G%d%@.png", i, picsizeStr];
        [picnames addObject:pic];
    }
    [XNGuideView showGudieView:picnames];      //传入图片图片名数据
}

- (void)goToUser
{
    if([Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
    {
        MineVC* vc = [[MineVC alloc] initWithNibName:@"MineVC" bundle:nil];
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

- (void)share
{
    if([Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
    {
        RecommendVC* vc = [[RecommendVC alloc] initWithNibName:@"RecommendVC" bundle:nil];
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
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"507fcab25270157b37000010"
//                                      shareText:@"你要分享的文字"
//                                     shareImage:[UIImage imageNamed:@"ico_1024.png"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,nil]
//                                       delegate:self];
    //[UMSocialSnsService presentSnsController:self appKey:@"507fcab25270157b37000010" shareText:@"你要分享的文字" shareImage:[UIImage imageNamed:@"ico_1024.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,nil] delegate:self];
}

- (void)SortGet
{
    [[NetWork shareInstance] Categary:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            NSArray* ary = [CatVO objectArrayWithKeyValuesArray:info[@"data"][@"sorts"]];
            [Utils archiveFacilityAry:ary];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)AreaGet
{
    [[NetWork shareInstance] Area:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            
            [[NSUserDefaults standardUserDefaults] setObject:info[@"data"] forKey:CITYAREAS];
            [[NSUserDefaults standardUserDefaults] synchronize];

        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)homeInfo
{
    [[NetWork shareInstance] homePage:@"" CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [self.recomandAry removeAllObjects];
            [_scrollView.mj_header endRefreshing];
            if(firstLauch||(_addsArray.count == 0))
            {
                NSMutableArray* bannerAry = [info[@"data"] objectForKey:@"banners"];
                [self setADS:bannerAry];
            }
            NSMutableArray* disPlayAry = [info[@"data"] objectForKey:@"display"];
            NSArray *userArray = [RecommendVO objectArrayWithKeyValuesArray:disPlayAry];
            [self.recomandAry addObjectsFromArray:userArray];
            [self.homeTable reloadData];
            firstLauch = NO;
        }
        else
        {
            [_scrollView.mj_header endRefreshing];
        }
    } FailBack:^(NSError *error) {
        [_scrollView.mj_header endRefreshing];
    }];
}

- (void)tableTest
{
    // 1.定义一个字典数组
    NSArray *dictArray = @[
                           @{
                               @"title" : @"测试美容院1",
                               @"icon" : @"default_marketing.png",
                               },
                           
                           @{
                               @"title" : @"测试美容院2",
                               @"icon" : @"default_marketing.png",
                               },
                           
                           @{
                               @"title" : @"测试美容院3",
                               @"icon" : @"default_marketing.png",
                               }
                           ];
    
    // 2.将字典数组转为User模型数组
    NSArray *userArray = [RecommendVO objectArrayWithKeyValuesArray:dictArray];
    [self.recomandAry addObjectsFromArray:userArray];
    [self.homeTable reloadData];
}

//广告页
- (void)initLoadView {
    if([XNAdvertisementView isExistsAdvertisementData]) {
        isExiststartpage = YES;
        [XNAdvertisementView showLoadingView];
    }
    NSString* urlStr;
    CGRect screenFram = [[UIScreen mainScreen] bounds];
    if(screenFram.size.height == 480)
        urlStr = @"640*960px";
    else
        urlStr = @"640*1136px";
    
    [[NetWork shareInstance] ad:urlStr CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            NSString* adStr;
            //adStr = [PIC_HOST stringByAppendingString:[dic[@"data"] objectForKey:@"path"]];
            adStr = [info[@"data"] objectForKey:@"path"];
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:adStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if(error) {
                    //isSaveStartPage(NO);
                }else if(image) {
                    [XNAdvertisementView saveAdvertisementImageAndActionUrl:image
                                                                   imageUrl:urlStr
                                                           advertisementUrl:@""];
                    //isSaveStartPage(YES);
                }
            }];
        }
        else
        {
            
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)addsTest
{
    NSString* picStr1 = @"default_marketing.png";
    NSString* picStr2 = @"default_marketing.png";
    NSString* picStr3 = @"default_marketing.png";
    NSArray* picArray = [NSArray arrayWithObjects:picStr1,picStr2,picStr3, nil];
    [self setADS:picArray];
}

- (void)setADS:(NSArray*)array
{
    CGRect rct = self.picScrollVoew.bounds;
    rct.size.width = SCREEN_WIDTH;
    self.picScrollVoew.frame = rct;
    
//    for (int m = 0; m<[[self.picScrollVoew subviews] count]; m++) {
//        UIImageView* imgView = [[self.picScrollVoew subviews] objectAtIndex:m];
//        [imgView removeFromSuperview];
//    }
    for (id view in [self.picScrollVoew subviews]) {
        [view removeFromSuperview];
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
        [btn addTarget:self action:@selector(adds:) forControlEvents:UIControlEventTouchUpInside];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[array objectAtIndex:i] objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
        //imageView.image = [UIImage imageNamed:[array objectAtIndex:i]];
        [self.picScrollVoew addSubview:imageView];
        [self.picScrollVoew addSubview:btn];
    }
    if([array count] != 0)
    {
        [self.addsArray removeAllObjects];
        [self.addsArray addObjectsFromArray:array];
    }
    //[UIImage imageNamed:@"hotelinfo_img_default.png"]
    _imagePage.numberOfPages = [array count];
    _imagePage.currentPage = 0;
    [_imagePage addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.picScrollVoew setContentSize:CGSizeMake(i*self.picScrollVoew.frame.size.width, self.picScrollVoew.bounds.size.height)];
    [self.picScrollVoew setUp:count];
}

- (void)adds:(id)sender
{
    AddsWebViewController *controller =[[AddsWebViewController alloc]initWithNibName:@"AddsWebViewController" bundle:nil];
    if(![[self.addsArray objectAtIndex:_imagePage.currentPage] objectForKey:@"link"]||[[[self.addsArray objectAtIndex:_imagePage.currentPage] objectForKey:@"link"] isEqualToString:@""])
        return;
    controller.webUrl = [[self.addsArray objectAtIndex:_imagePage.currentPage] objectForKey:@"link"];
    controller.title = [[self.addsArray objectAtIndex:_imagePage.currentPage] objectForKey:@"title"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.picScrollVoew]) {
        int page = scrollView.contentOffset.x / self.picScrollVoew.bounds.size.width;
        _imagePage.currentPage = page;
    }
}

- (void)changePage:(UIPageControl*)sender{
    if (self.picScrollVoew) {
        CGRect frame = self.picScrollVoew.bounds;
        frame.origin.x = frame.size.width * sender.currentPage;
        frame.origin.y = 0;
        [self.picScrollVoew scrollRectToVisible:frame animated:YES];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self homeInfo];
    [self AreaGet];
    [self SortGet];
    [self AppInfo];
    [Utils setupRefresh:_scrollView WithDelegate:self HeaderSelector:@selector(headerRefresh) FooterSelector:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view from its nib.
}

- (void)AppInfo
{
//    [[NetWork shareInstance] AppInfo:@"" callBack:^(MKNetworkOperation *completedOperation) {
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//        //这里可能会加入错误码的判断
//        if (!error)
//        {
//            if([dic[@"status"] intValue] == 0)
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:[[dic[@"data"] objectForKey:@"config"] objectForKey:@"phone"] forKey:PHONENUM];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
//            else
//            {
//                //[[XQTipInfoView getInstanceWithNib] appear:dic[@"msg"]];
//            }
//        }
//        else
//        {
//            
//        }
//    }failBack:^(MKNetworkOperation *completedOperation) {
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    ((NALNavigationController*)self.navigationController).canDragBack = YES;
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[Utils readUnarchiveHistoryGoodsVOsAry].iconUrl] placeholderImage:[UIImage imageNamed:@"defaulthead.png"]];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:CITYAREAS]&&[Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
        [self AreaGet];
    self.navigationController.navigationBar.hidden = NO;
    //[MobClick beginLogPageView:@"HomePage"];//("PageOne"为页面名称，可自定义)
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[MobClick endLogPageView:@"HomePage"];
}

- (void)headerRefresh {
    [self homeInfo];
}

- (void)footerRefresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //[self.makTbale reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        //[self.makTbale headerEndRefreshing];
        [_scrollView.mj_footer endRefreshingWithNoMoreData];
    });
}

- (void)relayOut:(NSInteger)count
{
    CGRect rct = self.recomandView.frame;
    rct.size.height = 30+count*168;
    self.recomandView.frame = rct;
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, rct.origin.y + rct.size.height+2)];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    [self relayOut:self.recomandAry.count];
    return self.recomandAry.count;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    static NSString *cellIdentifier = @"HomeCell";
    HomeCell *cell = (HomeCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [HomeCell getInstanceWithNib];
    }
    else{
        //NSLog(@"FixMentCell");
    }
    [cell setUI:self.recomandAry[row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebViewVC* vc = [[WebViewVC alloc] initWithNibName:@"WebViewVC" bundle:nil];
    RecommendVO* rVO = _recomandAry[indexPath.row];
    vc.currentVO = rVO;
    [self.navigationController pushViewController:vc animated:YES];
        //加入选择事件
}

- (IBAction)scan:(id)sender
{
    if([Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
    {
        NALScanViewController *scanVC = [[NALScanViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
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

- (IBAction)productCenter:(id)sender
{
    //产品中心
    ProductVC* vc = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)AppointService:(id)sender
{
    //预约服务
    AppointServiceVC* vc = [[AppointServiceVC alloc] initWithNibName:@"AppointServiceVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shoppingCar:(id)sender
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

- (IBAction)navigationNow:(id)sender
{
    //直接调用外部地图导航
    if([Utils readUnarchiveHistoryGoodsVOsAry].token&&![[Utils readUnarchiveHistoryGoodsVOsAry].token isEqualToString:@""])
    {
        CashBackVC* vc = [[CashBackVC alloc] initWithNibName:@"CashBackVC" bundle:nil];
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

- (IBAction)callNow:(id)sender
{
//    if([[NSUserDefaults standardUserDefaults] objectForKey:PHONENUM])
//        [[PriceDayView getInstanceWithNib] appearWithTitle:@"是否拨打电话?" Tip:@"提示" CommitTitle:@"确定" Delegate:self Row:0];
//    else
//    {
//        [[NetWork shareInstance] AppInfo:@"" callBack:^(MKNetworkOperation *completedOperation) {
//            NSError *error;
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//            //这里可能会加入错误码的判断
//            if (!error)
//            {
//                if([dic[@"status"] intValue] == 0)
//                {
//                    [[NSUserDefaults standardUserDefaults] setObject:[[dic[@"data"] objectForKey:@"config"] objectForKey:@"phone"] forKey:PHONENUM];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    [[PriceDayView getInstanceWithNib] appearWithTitle:@"是否拨打电话?" Tip:@"提示" CommitTitle:@"确定" Delegate:self Row:0];
//                }
//                else
//                {
//                    [[XQTipInfoView getInstanceWithNib] appear:@"联系信息获取失败"];
//                }
//            }
//            else
//            {
//                [[XQTipInfoView getInstanceWithNib] appear:@"联系信息获取失败"];
//            }
//        }failBack:^(MKNetworkOperation *completedOperation) {
//            [[XQTipInfoView getInstanceWithNib] appear:@"联系信息获取失败"];
//        }];
//    }
}

- (void)OKDayPress:(NSString *)nomalPrice Row:(NSInteger)row
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSString* str = [[NSUserDefaults standardUserDefaults] objectForKey:PHONENUM];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]];
    if(!telURL)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"电话号码有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    // 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    
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
