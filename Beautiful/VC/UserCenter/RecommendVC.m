//
//  RecommendVC.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "RecommendVC.h"
#import "ReHeadCell.h"
#import "RecommendCell.h"
#import <UMSocialCore/UMSocialCore.h>
@interface RecommendVC ()<ReHeadCellDelegate>
{
    NSString* cardID;
}
@end

@implementation RecommendVC

- (void)setUI
{
    self.title = @"我的推荐";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    _dataAry = [[NSMutableArray alloc] init];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //[self setNeedsStatusBarAppearanceUpdate];
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
    //if(![Utils readUnarchiveHistoryGoodsVOsAry])
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData
{
    [[NetWork shareInstance] MyRecommend:[Utils readUnarchiveHistoryGoodsVOsAry].token CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            cardID = [info[@"data"] objectForKey:@"inviteCode"];
            NSMutableArray *dataAry = [info[@"data"] objectForKey:@"recommends"];
            NSArray* orderAry = [RecomVO objectArrayWithKeyValuesArray:dataAry];
            [_dataAry addObjectsFromArray:orderAry];
            [_table reloadData];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (void)test
{
    
    
//    @property (nonatomic, strong) NSString* icon;
//    @property (nonatomic, strong) NSString* name;
//    @property (nonatomic, strong) NSString* time;
//    @property (nonatomic, strong) NSString* money;
//    @property (nonatomic, strong) NSString* comeFrom;
    
    NSArray *dictArray = @[
                           @{
                               @"icon" : @"",
                               @"name" : @"啊西吧",
                               @"time" : @"2016-11-02 23:02:09",
                               @"money" : @"20",
                               @"comeFrom" : @"注册",
                               },
                           
                           @{
                               @"icon" : @"",
                               @"name" : @"啊你哟",
                               @"time" : @"2016-11-02 23:02:09",
                               @"money" : @"100",
                               @"comeFrom" : @"推荐",
                               },
                           
                           @{
                               @"icon" : @"",
                               @"name" : @"卡机嘛",
                               @"time" : @"2016-11-02 23:02:09",
                               @"money" : @"258",
                               @"comeFrom" : @"系统赠送",
                               }
                           ];
    
    // 2.将字典数组转为User模型数组
    NSArray *userArray = [RecomVO objectArrayWithKeyValuesArray:dictArray];
    [self.dataAry addObjectsFromArray:userArray];
    [self.table reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0)
        return 1;
    else
        return _dataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    else
        return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    if(section == 1)
    {
        vv.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH-14, 30)];
        label.text = @"我的推荐";
        label.textColor = [Utils colorWithHexString:@"888888"];
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        [vv addSubview:label];
    }
    return vv;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
        return 164;
    else
        return 84;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if(section == 0)
    {
        static NSString *cellIdentifier = @"ReHeadCell";
        ReHeadCell *cell = (ReHeadCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [ReHeadCell getInstanceWithNib];
        }
        else{
            //NSLog(@"FixMentCell");
        }
        [cell setUI:cardID];
        cell.delegate = self;
        //cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"RecommendCell";
        RecommendCell *cell = (RecommendCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [RecommendCell getInstanceWithNib];
        }
        else{
            //NSLog(@"FixMentCell");
        }
        [cell setUI:_dataAry[row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSInteger row = indexPath.row;
}

- (void)copyCode
{
    //复制code
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"JBKL1415";
    [[XQTipInfoView getInstanceWithNib] appear:@"已复制"];
}

- (void)weiChat
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"ico_120"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)weiChatTimeLine
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"ico_120"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
    
}

- (void)sina
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)QQ
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"ico_120"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
    
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
