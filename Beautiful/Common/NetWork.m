//
//  NetWork.m
//  Hotel
//
//  Created by S on 15-7-7.
//  Copyright (c) 2015年 UU. All rights reserved.
//

#import "NetWork.h"
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@implementation NetWork
+ (NetWork*)shareInstance{
    static NetWork *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singletion=[[NetWork alloc]init];
    });
    return __singletion;
}

- (void)showHud
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
    p_progressHUD  = [[MBProgressHUD alloc] initWithView:MyAppDelegate.window];
    p_progressHUD.mode = MBProgressHUDModeIndeterminate;
    [MyAppDelegate.window addSubview:p_progressHUD];
    [p_progressHUD show:YES];
}

- (void)disMisHud
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
}

- (BOOL)tokenOutDate:(NSDictionary*)infoDic Error:(NSError*)error
{
    if(!error&&[Utils TokenOutDate:infoDic])
    {
        //这里调用token失效跳转重新登录界面
        UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
        uVO.token = @"";
        [Utils archiveHistoryGoodsVOsAry:uVO];
        //[(AppDelegate*)MyAppDelegate switchLoginStatue:NO];
        return YES;
    }
    else
        return NO;
}

- (void)HRNetStar:(NSString*)path Params:(NSMutableDictionary*)params CallBack:(void(^)(BOOL, NSDictionary*))callBlock FailBack:(void(^)(NSError*))failBlock
{
    MKNetworkHost *engine = [[MKNetworkHost alloc] initWithHostName:API_HOST Path:path];
    MKNetworkRequest *operation = [engine requestWithPath:nil params:params httpMethod:@"POST"];
    // 添加网络请求完成处理逻辑
    [operation addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        if(completedRequest.state == MKNKRequestStateCompleted)
        {
            NSError *error;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedRequest responseData] options:NSJSONReadingMutableLeaves error:&error];
            if([self tokenOutDate:dic Error:error])
                
                return;
            if (!error&&[Utils NetStatus:dic])
                callBlock(YES,dic);
            else
            {
                if(dic[@"msg"])
                    [Utils showMSG:dic[@"msg"]];
                else
                    [Utils showMSG:@"网络错误"];
                callBlock(NO,nil);
            }
            //[self disMisHud];
        }
        else if(completedRequest.state == MKNKRequestStateError)
        {
            failBlock(completedRequest.error);
            [Utils showMSG:@"网络错误"];
            //[self disMisHud];
        }
        
    }];
    // 发送网络请求
    [engine startRequest:operation];
}

#pragma mark-Old


//广告页
- (void)ad:(NSString*)resolution CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"startup"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:resolution forKey:@"resolution"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//退出登录
- (void)loginOut:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"base!logout.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

- (void)verifyCode:(NSString*)phone Type:(NSString*)type CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"base!verify.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:phone forKey:@"phone"];
    [params setObject:[NSNumber numberWithInt:[type intValue]] forKey:@"type"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//登录
- (void)login:(NSString*)phone Password:(NSString*)password CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"base!login.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:phone forKey:@"phone"];
    [params setObject:[password md5] forKey:@"password"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//三方登录
- (void)login:(NSString*)type ThirdId:(NSString*)thirdId ThirdName:(NSString*)thirdName CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"base!loginByThird.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:type forKey:@"type"];
    [params setObject:thirdId forKey:@"thirdId"];
    [params setObject:thirdName forKey:@"thirdName"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//注册
- (void)regist:(NSString*)phone Password:(NSString*)password Code:(NSString*)code InviteCode:(NSString*)inviteCode CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"base!register.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:phone forKey:@"phone"];
    [params setObject:[password md5] forKey:@"password"];
    [params setObject:code forKey:@"code"];
    [params setObject:inviteCode forKey:@"inviteCode"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//找回密码
- (void)findPSW:(NSString*)phone Password:(NSString*)password Code:(NSString*)code CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"base!resetPwd.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:phone forKey:@"phone"];
    [params setObject:[password md5] forKey:@"password"];
    [params setObject:code forKey:@"code"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//首页信息
- (void)homePage:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    
    NSString *path = [NSString stringWithFormat:@"index!index.action"];
    //NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //[params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:nil CallBack:callBlock FailBack:failBlock];
}

//营销活动
- (void)activity:(NSString*)token Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    
    NSString *path = [NSString stringWithFormat:@"activity"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//搜索装修单
- (void)SearchFit:(NSString*)token KeyWords:(NSString*)keyWords Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"fitment/search"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:keyWords forKey:@"keyWords"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//搜索报修单
- (void)SearchFix:(NSString*)token KeyWords:(NSString*)keyWords Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"repair/search"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:keyWords forKey:@"keyWords"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//搜索
- (void)SearchKnowledge:(NSString*)token KeyWords:(NSString*)keyWords Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"knowledge"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:keyWords forKey:@"keyWords"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//个人信息
- (void)UserInfo:(NSString*)token IconUrl:(NSString*)iconUrl Name:(NSString*)name Address:(NSString*)address CompanyId:(NSString*)companyId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"info!updateUserInfo.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:iconUrl forKey:@"iconUrl"];
    [params setObject:name forKey:@"name"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//修改电话
- (void)modifyTel:(NSString*)token Phone:(NSString*)phone Code:(NSString*)code CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"changePhone"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:code forKey:@"code"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//修改密码
- (void)modifyPSW:(NSString*)token OldPassword:(NSString*)oldPassword NewPassword:(NSString*)newPassword CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"info!updatePwd.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[oldPassword md5] forKey:@"oldPassword"];
    [params setObject:[newPassword md5] forKey:@"newPassword"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//意见反馈
- (void)suggest:(NSString*)token Suggestion:(NSString*)suggestion CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"info!feedback.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:suggestion forKey:@"suggestion"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];}

//地址列表
- (void)addressGet:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"info!queryAddr.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

- (void)addressDefault:(NSString*)token AddrId:(NSString*)addrId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"info!updateDefaultAddr.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:addrId forKey:@"addrId"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//删除地址
- (void)addressDelete:(NSString*)token AddrId:(NSString*)addrId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"info!deleteAddr.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:addrId forKey:@"addrId"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//新建编辑地址
- (void)addressSet:(NSString*)token AddrId:(NSString*)addrId Name:(NSString*)name Phone:(NSString*)phone Province:(NSString*)province City:(NSString*)city Country:(NSString*)county Detail:(NSString*)detail Def:(NSString*)def CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"info!updateAddr.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:addrId forKey:@"addrId"];
    [params setObject:name forKey:@"name"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:province forKey:@"province"];
    [params setObject:city forKey:@"city"];
    [params setObject:county forKey:@"county"];
    [params setObject:detail forKey:@"detail"];
    [params setObject:[NSNumber numberWithInt:0] forKey:@"def"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//我的订单
- (void)OrderCenter:(NSString*)token OrderType:(int)orderType Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!queryOrders.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:orderType] forKey:@"orderType"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}


//我的拼团
- (void)myTeamOrders:(NSString*)token Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"teamproduct!queryTeamOrders.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}


//产品中心
- (void)productCenter:(int)cId ZId:(int)zId Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!queryProducts.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:cId] forKey:@"productType"];
    [params setObject:[NSNumber numberWithInt:zId] forKey:@"zId"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//产品详情
- (void)productDetial:(NSString*)productId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!queryProductDetail.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:productId forKey:@"productId"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//加入购物车
- (void)addToShopCar:(NSString*)token ProductId:(NSString*)productId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!addToShoppingCart.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:productId forKey:@"productId"];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//关注
- (void)focus:(NSString*)token ProductId:(NSString*)productId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!addToCollection.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:productId forKey:@"productId"];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//服务列表
- (void)severList:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"service!queryServices.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//服务详情
- (void)severDetial:(NSString*)serviceId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"service!queryServiceItem.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:serviceId forKey:@"serviceId"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//代金券列表
- (void)CardList:(NSString*)token CashCouponType:(int)cashCouponType CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"wallet!queryCashCoupons.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[NSNumber numberWithInt:cashCouponType] forKey:@"cashCouponType"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}
//购物车列表
- (void)ShopCarList:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!queryShoppingCarts.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];}

//购物车删除
- (void)ShopCarDelete:(NSString*)token CartIds:(NSMutableArray*)cartIds CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!deleteShoppingCarts.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[Utils getStrFromArray:cartIds] forKey:@"cartIds"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//购物车数量修改
- (void)ShopCarNumChange:(NSString*)token CartId:(NSString*)cartId BuyNum:(int)buyNum CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!updateBuyNum.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:cartId forKey:@"productId"];
    [params setObject:[NSNumber numberWithInt:buyNum] forKey:@"buyNum"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//我的收藏
- (void)MyFav:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!queryCollections.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//取消收藏
- (void)FavCancel:(NSString*)token CollectionId:(NSString*)collectionId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!cancelCollection.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:collectionId forKey:@"collectionId"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//钱包余额获取
- (void)Money:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    
    NSString *path = [NSString stringWithFormat:@"wallet!queryBalance.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//钱包明细获取
- (void)MoneyDetial:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"wallet!queryBill.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//我的推荐列表
- (void)MyRecommend:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"info!recommend.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//我的预约列表
- (void)MyService:(NSString*)token Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"service!queryMyServices.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];

}

//确认订单接口
- (void)OrderCommit:(NSString*)token Products:(NSMutableArray*)products OrderNo:(NSString*)orderNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!confirmOrder.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[Utils getStrFromArray:products] forKey:@"products"];
    [params setObject:orderNo forKey:@"orderNo"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//提交购买
- (void)OrderPay:(NSString*)token AddrId:(NSString*)addrId Products:(NSMutableArray*)products DeliveryType:(NSString*)deliveryType CashCouponId:(NSString*)cashCouponId PayType:(NSString*)payType orderNo:(NSString*)orderNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!buyProduct.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:addrId forKey:@"addrId"];
    [params setObject:deliveryType forKey:@"deliveryType"];
    [params setObject:cashCouponId forKey:@"cashCouponId"];
    [params setObject:payType forKey:@"payType"];
    [params setObject:[Utils getStrFromArray:products] forKey:@"products"];
    [params setObject:orderNo forKey:@"orderNo"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//提交预约
- (void)ServicePay:(NSString*)token ServiceId:(NSString*)serviceId SubscribeTime:(NSString*)subscribeTime CashCouponId:(NSString*)cashCouponId PayType:(NSString*)payType CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"service!subscribeService.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:serviceId forKey:@"serviceId"];
    [params setObject:subscribeTime forKey:@"subscribeTime"];
    [params setObject:cashCouponId forKey:@"cashCouponId"];
    [params setObject:payType forKey:@"payType"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//余额提现
- (void)CashOut:(NSString*)token DrawType:(int)drawType Amount:(NSString*)amount Customer:(NSString*)customer Account:(NSString*)account Bank:(NSString*)bank CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"wallet!drawCash.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:amount forKey:@"amount"];
    [params setObject:customer forKey:@"customer"];
    [params setObject:account forKey:@"account"];
    [params setObject:bank forKey:@"bank"];
    [params setObject:[NSNumber numberWithInt:drawType] forKey:@"drawType"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//取消订单
- (void)CancelOrder:(NSString*)token OrderNo:(NSString*)orderNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!cancelOrder.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:orderNo forKey:@"orderNo"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//确认收货
- (void)MakeSure:(NSString*)token OrderNo:(NSString*)orderNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!sureReceiveProduct.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:orderNo forKey:@"orderNo"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//配置信息
- (void)AppInfo:(NSString*)type CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"index!config.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"IOS" forKey:@"type"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//领取代金券
- (void)CouponGet:(NSString*)token CouponNo:(NSString*)couponNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"wallet!drawCoupon.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:couponNo forKey:@"couponNo"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];

}

//购物返现
- (void)CashBackList:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"wallet!backCash.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//消息
- (void)Notify:(NSString*)token Type:(int)type Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"message"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:token forKey:@"token"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}
#pragma mark-New
//地区
- (void)Area:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"base!queryAddrMetaToIOS.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}

//分类接口
- (void)Categary:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"product!queryProductSort.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}
    
//拼团列表
- (void)PinList:(int)zId Cid:(int)cId Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"teamproduct!queryTeamProducts.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:cId] forKey:@"productType"];
    [params setObject:[NSNumber numberWithInt:zId] forKey:@"zId"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}
    
//拼团详情
- (void)PinDetial:(NSString*)teamId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"teamproduct!queryTeamProductDetail.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:teamId forKey:@"teamProductId"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}
    
//拼团确认
- (void)PinConfig:(NSString*)token TeamId:(NSString*)teamId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
{
    NSString *path = [NSString stringWithFormat:@"teamproduct!confirmTeamOrder.action"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:teamId forKey:@"teamProductId"];
    [params setObject:token forKey:@"token"];
    [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
}
    
    //我的拼团列表
- (void)MyPinglist:(NSString*)token Type:(int)type Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
    {
        NSString *path = [NSString stringWithFormat:@"message"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:token forKey:@"token"];
        [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
        [params setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
        [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
    }
    //拼团付款接口
- (void)PingPay:(NSString*)token AddrId:(NSString*)addrId TeamId:(NSString*)teamId CashCouponId:(NSString*)cashCouponId PayType:(NSString*)payType CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock
    {
        NSString *path = [NSString stringWithFormat:@"teamproduct!buyProduct.action"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:token forKey:@"token"];
        [params setObject:addrId forKey:@"addrId"];
        [params setObject:teamId forKey:@"teamProductId"];
        [params setObject:cashCouponId forKey:@"cashCouponId"];
        [params setObject:payType forKey:@"payType"];
        [self HRNetStar:path Params:params CallBack:callBlock FailBack:failBlock];
    }
@end
