//
//  NetWork.h
//  Hotel
//
//  Created by S on 15-7-7.
//  Copyright (c) 2015年 UU. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CallbackResult)(id result);
@interface NetWork : NSObject
{
    MBProgressHUD* p_progressHUD;
}
@property (strong, nonatomic) CallbackResult callbackResult;

//
+ (NetWork*)shareInstance;
//////公共类

//广告页
- (void)ad:(NSString*)resolution CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//退出登录
- (void)loginOut:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//验证码
- (void)verifyCode:(NSString*)phone Type:(NSString*)type CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//登录
- (void)login:(NSString*)phone Password:(NSString*)password CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//三方登录
- (void)login:(NSString*)type ThirdId:(NSString*)thirdId ThirdName:(NSString*)thirdName CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//注册
- (void)regist:(NSString*)phone Password:(NSString*)password Code:(NSString*)code InviteCode:(NSString*)inviteCode CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//找回密码
- (void)findPSW:(NSString*)phone Password:(NSString*)password Code:(NSString*)code CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//首页信息
- (void)homePage:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//营销活动
- (void)activity:(NSString*)token Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//搜索
- (void)SearchKnowledge:(NSString*)token KeyWords:(NSString*)keyWords Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//搜索装修单
- (void)SearchFit:(NSString*)token KeyWords:(NSString*)keyWords Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//搜索报修单
- (void)SearchFix:(NSString*)token KeyWords:(NSString*)keyWords Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//个人信息
- (void)UserInfo:(NSString*)token IconUrl:(NSString*)iconUrl Name:(NSString*)name Address:(NSString*)address CompanyId:(NSString*)companyId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//修改电话
- (void)modifyTel:(NSString*)token Phone:(NSString*)phone Code:(NSString*)code CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//修改密码
- (void)modifyPSW:(NSString*)token OldPassword:(NSString*)oldPassword NewPassword:(NSString*)newPassword CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//意见反馈
- (void)suggest:(NSString*)token Suggestion:(NSString*)suggestion CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//地址列表
- (void)addressGet:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//设置默认地址
- (void)addressDefault:(NSString*)token AddrId:(NSString*)addrId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//删除地址
- (void)addressDelete:(NSString*)token AddrId:(NSString*)addrId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//新建编辑地址
- (void)addressSet:(NSString*)token AddrId:(NSString*)addrId Name:(NSString*)name Phone:(NSString*)phone Province:(NSString*)province City:(NSString*)city Country:(NSString*)county Detail:(NSString*)detail Def:(NSString*)def CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//我的订单
- (void)OrderCenter:(NSString*)token OrderType:(int)orderType Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//我的拼团
- (void)myTeamOrders:(NSString*)token Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//产品中心
- (void)productCenter:(int)cId ZId:(int)zId Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//产品详情
- (void)productDetial:(NSString*)productId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//加入购物车
- (void)addToShopCar:(NSString*)token ProductId:(NSString*)productId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//关注
- (void)focus:(NSString*)token ProductId:(NSString*)productId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//服务列表
- (void)severList:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//服务详情
- (void)severDetial:(NSString*)serviceId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//代金券列表
- (void)CardList:(NSString*)token CashCouponType:(int)cashCouponType CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//购物车列表
- (void)ShopCarList:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//购物车删除
- (void)ShopCarDelete:(NSString*)token CartIds:(NSMutableArray*)cartIds CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//购物车数量修改
- (void)ShopCarNumChange:(NSString*)token CartId:(NSString*)cartId BuyNum:(int)buyNum CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//我的收藏
- (void)MyFav:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//取消收藏
- (void)FavCancel:(NSString*)token CollectionId:(NSString*)collectionId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//钱包余额获取
- (void)Money:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//钱包明细获取
- (void)MoneyDetial:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//我的推荐列表
- (void)MyRecommend:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//我的预约列表
- (void)MyService:(NSString*)token Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//确认订单接口
- (void)OrderCommit:(NSString*)token Products:(NSMutableArray*)products OrderNo:(NSString*)orderNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//提交购买
- (void)OrderPay:(NSString*)token AddrId:(NSString*)addrId Products:(NSMutableArray*)products DeliveryType:(NSString*)deliveryType CashCouponId:(NSString*)cashCouponId PayType:(NSString*)payType orderNo:(NSString*)orderNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//提交预约
- (void)ServicePay:(NSString*)token ServiceId:(NSString*)serviceId SubscribeTime:(NSString*)subscribeTime CashCouponId:(NSString*)cashCouponId PayType:(NSString*)payType CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//余额提现
- (void)CashOut:(NSString*)token DrawType:(int)drawType Amount:(NSString*)amount Customer:(NSString*)customer Account:(NSString*)account Bank:(NSString*)bank CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//取消订单
- (void)CancelOrder:(NSString*)token OrderNo:(NSString*)orderNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//确认收货
- (void)MakeSure:(NSString*)token OrderNo:(NSString*)orderNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//配置信息
- (void)AppInfo:(NSString*)type CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//领取代金券
- (void)CouponGet:(NSString*)token CouponNo:(NSString*)couponNo CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//购物返现
- (void)CashBackList:(NSString*)token CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//消息
- (void)Notify:(NSString*)token Type:(int)type Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;
    
    
    
#pragma mark-New
//地区
- (void)Area:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;


//分类接口
- (void)Categary:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;
    
//拼团列表
- (void)PinList:(int)zId Cid:(int)cId Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;

//拼团详情
- (void)PinDetial:(NSString*)teamId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;
    
//拼团确认
- (void)PinConfig:(NSString*)token TeamId:(NSString*)teamId CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;
    
//我的拼团列表
- (void)MyPinglist:(NSString*)token Type:(int)type Page:(int)page PageSize:(int)pageSize CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;
    
//拼团付款接口
- (void)PingPay:(NSString*)token AddrId:(NSString*)addrId TeamId:(NSString*)teamId CashCouponId:(NSString*)cashCouponId PayType:(NSString*)payType CallBack:(void(^)(BOOL isSucc, NSDictionary* info))callBlock FailBack:(void(^)(NSError* error))failBlock;
@end
