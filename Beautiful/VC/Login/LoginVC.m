//
//  LoginVC.m
//  Beautiful
//
//  Created by S on 16/1/25.
//  Copyright © 2016年 B. All rights reserved.
//
#import <UMSocialCore/UMSocialCore.h>
#import "LoginVC.h"
#import "AppDelegate.h"
#import "XGPush.h"
#import "XNGuideView.h"
#import "ImgConfigVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)setUI
{
    self.title = @"登录";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    UIButton* reistBtn = [Utils createButtonWith:CustomButtonType_Text text:nil];
    [reistBtn setTitle:@"注册" forState:UIControlStateNormal];
    [reistBtn addTarget:self action:@selector(regeist:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:reistBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    [Utils cornerView:self.firstView withRadius:3 borderWidth:1 borderColor:[Utils colorWithHexStringWithAlpha:@"B3B3B3" Alpha:0.3]];
    [Utils cornerView:self.loginBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
    self.view.backgroundColor = [Utils colorWithHexString:@"f7f7f7"];
    [self.scrollView setContentSize:CGSizeMake(320, 480)];
    //[self initGuideView];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Do any additional setup after loading the view from its nib.
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.accountTxt resignFirstResponder];
    [self.pswTxt resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"%lu,%lu",(unsigned long)range.location,(unsigned long)range.length);
    //NSLog(@"%@",string);
    
    if(textField == self.accountTxt)
    {
        if(([@"0123456789" rangeOfString:string].length == 0&&![string isEqualToString:@""])||(self.accountTxt.text.length>=11&&range.length==0))
            return NO;
        else
            return YES;
    }
    else if(textField == self.pswTxt)
    {
        if(([@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" rangeOfString:string].length == 0&&![string isEqualToString:@""]))
            return NO;
        else
            return YES;
    }
    
    else
        return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.accountTxt resignFirstResponder];
    [self.pswTxt resignFirstResponder];
    return YES;
}

- (IBAction)login:(id)sender
{
    if([self.accountTxt.text isEqualToString:@""])
    {
        [[XQTipInfoView getInstanceWithNib] appear:@"手机号码输入有误"];
        return;
    }
    if([self.pswTxt.text isEqualToString:@""])
    {
        [[XQTipInfoView getInstanceWithNib] appear:@"请输入密码"];
        return;
    }
    [[NetWork shareInstance] login:_accountTxt.text Password:_pswTxt.text CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            NSDictionary* infoDic = info[@"data"];
            UserVO* uVO = [UserVO objectWithKeyValues:infoDic];
            [Utils archiveHistoryGoodsVOsAry:uVO];
            NSUserDefaults* userDic = [NSUserDefaults standardUserDefaults];
            [userDic setObject:LOGIN forKey:USER_LOGIN_STATUE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [(AppDelegate*)MyAppDelegate switchLoginStatus];
            [[XQTipInfoView getInstanceWithNib] appear:@"登陆成功"];
            [self clickBack:nil];
        }
    } FailBack:^(NSError *error) {
         
    }];
}

- (IBAction)regeist:(id)sender
{
    ImgConfigVC* vc = [[ImgConfigVC alloc] initWithNibName:@"ImgConfigVC" bundle:nil];
    ((ImgConfigVC*)vc).imgType = @"0";
    ((ImgConfigVC*)vc).title = @"注册";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)forget:(id)sender
{
    ImgConfigVC* vc = [[ImgConfigVC alloc] initWithNibName:@"ImgConfigVC" bundle:nil];
    ((ImgConfigVC*)vc).imgType = @"1";
    ((ImgConfigVC*)vc).title = @"忘记密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)weiChatLogin:(id)sender
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [[XQTipInfoView getInstanceWithNib] appear:@"登录信息获取失败"];
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            [[NetWork shareInstance] login:@"WX" ThirdId:resp.uid ThirdName:resp.name CallBack:^(BOOL isSucc, NSDictionary *info) {
                if(isSucc)
                {
                    NSDictionary* infoDic = info[@"data"];
                    UserVO* uVO = [UserVO objectWithKeyValues:infoDic];
                    uVO.iconUrl = resp.iconurl;
                    uVO.username = resp.name;
                    [Utils archiveHistoryGoodsVOsAry:uVO];
                    NSUserDefaults* userDic = [NSUserDefaults standardUserDefaults];
                    [userDic setObject:LOGIN forKey:USER_LOGIN_STATUE];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [(AppDelegate*)MyAppDelegate switchLoginStatus];
                    [[XQTipInfoView getInstanceWithNib] appear:@"登陆成功"];
                    [self clickBack:nil];
                }
            } FailBack:^(NSError *error) {
                
            }];
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (IBAction)QQLogin:(id)sender
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            [[NetWork shareInstance] login:@"QQ" ThirdId:resp.uid ThirdName:resp.name CallBack:^(BOOL isSucc, NSDictionary *info) {
                if(isSucc)
                {
                    NSDictionary* infoDic = info[@"data"];
                    UserVO* uVO = [UserVO objectWithKeyValues:infoDic];
                    uVO.iconUrl = resp.iconurl;
                    uVO.username = resp.name;
                    [Utils archiveHistoryGoodsVOsAry:uVO];
                    NSUserDefaults* userDic = [NSUserDefaults standardUserDefaults];
                    [userDic setObject:LOGIN forKey:USER_LOGIN_STATUE];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [(AppDelegate*)MyAppDelegate switchLoginStatus];
                    [[XQTipInfoView getInstanceWithNib] appear:@"登陆成功"];
                    [self clickBack:nil];
                }
            } FailBack:^(NSError *error) {
                
            }];

            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];

}

- (IBAction)WeiboLogin:(id)sender
{
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        
//        //          获取微博用户名、uid、token等
//        
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
//            
//            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//            [[NetWork shareInstance] login:@"WB" ThirdId:snsAccount.usid ThirdName:snsAccount.userName CallBack:^(BOOL isSucc, NSDictionary *info) {
//                if(isSucc)
//                {
//                    NSDictionary* infoDic = info[@"data"];
//                    UserVO* uVO = [UserVO objectWithKeyValues:infoDic];
//                    uVO.iconUrl = snsAccount.iconURL;
//                    uVO.username = snsAccount.userName;
//                    [Utils archiveHistoryGoodsVOsAry:uVO];
//                    NSUserDefaults* userDic = [NSUserDefaults standardUserDefaults];
//                    [userDic setObject:LOGIN forKey:USER_LOGIN_STATUE];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    [(AppDelegate*)MyAppDelegate switchLoginStatus];
//                    [[XQTipInfoView getInstanceWithNib] appear:@"登陆成功"];
//                    [self clickBack:nil];
//                }
//            } FailBack:^(NSError *error) {
//                
//            }];
//            
//        }
//        else
//        {
//            [[XQTipInfoView getInstanceWithNib] appear:@"登录信息获取失败"];
//        }
//        
//    });
}

- (IBAction)test:(id)sender
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
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
