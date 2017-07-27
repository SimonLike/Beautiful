//
//  Global.h
//  XQExpressCourier
//
//  Created by xf.lai on 14/8/11.
//  Copyright (c) 2014年 xf.lai. All rights reserved.
//



#if	1
#define DLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DLog(format, ...)
#endif


#define XNSCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define XNSCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)


#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)

#define IS_IOS7_Later ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f)

#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)

#define IS_IOS8_0_2 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.2f && [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)

#define IS_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)


/**
 *
 * APP TYPE
 *
 */
//IM
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IMACCOUNT @"IMACCOUNT"
#define IMPASSWORD @"IMPASSWORD"

//IM
#define APP_TYPE @"APP_TYPE"//Courier--快递端，User--用户端

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define FontColor [UIColor colorWithRed:76/255.0 green:176/255.0 blue:52/255.0 alpha:1.0]
#define PNG_FROM_NAME(_PNGFILE)  ([UIImage imageNamed:_PNGFILE])
/**
 *
 * API相关
 *
 */
//测试服务器接口地址：
//http://mapi.u6u.com:88
//正式服务器接口地址：
//http://ek.u6u.com


#define HTTPType @"http" //https
#define API_HOST @"api.pengchenggou.com:8080/zdry"
#define PIC_HOST @"http://api.pengchenggou.com:8080/zdry"
#define POST_KEY_METHOD         @"POST"
#define INT_REQUEST_TIMEOUT 30
#define SAVERITEMS @"SAVERITEMS"
/**
 *
 * 支付宝相关
 *
 */
#define AppScheme @"User"

#define PHONENUM @"PHONENUM"

//MJRefresh HIHT TEXT
#define     MJREFRESH_DOWN_Title1                   @"下拉刷新"
#define     MJREFRESH_DOWN_Title2                   @"释放刷新"
#define     MJREFRESH_DOWN_Title3                   @"正在刷新"

#define     MJREFRESH_UP_Title1                     @"上滑加载更多"
#define     MJREFRESH_UP_Title2                     @"释放刷新"
#define     MJREFRESH_UP_Title3                     @"正在加载"
#define     MJREFRESH_UP_Title4                     @"没有更多了"


#define DEFAULTCOLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]
#define HKTITLECOLOR [UIColor colorWithRed:34/255.0 green:170/255.0 blue:238/255.0 alpha:1.0]

/**
 * AppDelegate
 */
#define MyAppDelegate	 [UIApplication sharedApplication].delegate
#define kTabBarHeight 50.0f//tabbar高度

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
#define IOS7_SDK_AVAILABLE 1
#endif

#define USER_UUID @"USER_UUID"
#define USER_ID_KEY @"USER_ID_KEY"
#define USER_VO_KEY  @"USER_VO_KEY"
#define USERDEFAULTS_TOKEN_KEY @"USERDEFAULTS_TOKEN_KEY"
#define USERDEFAULTS_USER_ID_KEY @"USERDEFAULTS_USER_ID_KEY"
#define HOTELADMIN @"HOTELADMIN"

#define USER_LOGIN_STATUE @"USER_LOGIN_STATUE"
#define LOGINOUT @"LOGINOUT"
#define LOGIN @"LOGIN"

#define USERNEED @"USERNEED"
#define PAYSUCCESS @"PAYSUCCESS"

#define UNREAD @"UNREAD"
#define READED @"READED"
#define ORDERUNREAD @"ORDERUNREAD"
#define ORDERREADED @"ORDERREADED"


//登录
#define USEHUANPWD @"u6u123"
#define USERINFO @"USERINFO"
//设置
#define INFOON @"INFOON"
#define VOIDCEON @"VOIDCEON"
#define VVON @"VVON"
//设施
#define FACILITY @"FACILITY"


#define USERDEFAULTS_USER_VO_KEY @"USERDEFAULTS_USER_VO_KEY"
#define USERDEFAULTS_USER_PHONE_NUM_KEY @"USERDEFAULTS_USER_PHONE_NUM_KEY"
#define USERDEFAULTS_NETWORK_KEY @"USERDEFAULTS_NETWORK_KEY"//network
#define USERDEFAULTS_SHOW_IMG_ONLY_IN_WIFI_KEY @"USERDEFAULTS_SHOW_IMG_ONLY_IN_WIFI_KEY"//显示图片
#define USERDEFAULTS_HISTORY_GOODS_DATA_KEY @"USERDEFAULTS_HISTORY_GOODS_DATA_KEY"//浏览记录

//########## Login and Register #################################//
#define NOTIFICATION_LOGION_SUCCESSFUL @"NOTIFICATION_LOGION_SUCCESSFUL"
#define NOTIFICATION_REGISTER_SUCCESSFUL @"NOTIFICATION_REGISTER_SUCCESSFUL"
#define NOTIFICATION_LOGOUT_SUCCESS @"NOTIFICATION_LOGOUT_SUCCESS"//退出


//########## notification of tabbar #################################//
#define NOTIFICATION_RESET_TABBAR   @"NOTIFICATION_RESET_TABBAR"

//########## notification of tabbar #################################//
#define NOTIFICATION_GET_ORDER_SUCESS   @"NOTIFICATION_GET_ORDER_SUCESS"

//########## notification of tabbar #################################//
#define NOTIFICATION_GOTOORDER_TABBAR   @"NOTIFICATION_GOTOORDER_TABBAR"

//########## notification of tabbar #################################//
#define NOTIFICATION_GOTOPLAY_TABBAR   @"NOTIFICATION_GOTOPLAY_TABBAR"

//########## notification of tabbar #################################//
#define NOTIFICATION_GOTOMYORDER_TABBAR   @"NOTIFICATION_GOTOMYORDER_TABBAR"




//########## share #################################//
#define SHARE_SDK_APP_KEY @"4b7b27fbc88a"
#define SHARE_SDK_APP_SECRET @"40288de4d89b252d9a39d69a7aa1538e"
#define SHARE_SINA_WEIBO_APP_KEY @"4b7b27fbc88a"
#define SHARE_SINA_WEIBO_APP_SECRET @"40288de4d89b252d9a39d69a7aa1538e"
#define SHARE_QZONE_APP_KEY @"4b7b27fbc88a"
#define SHARE_QZONE_APP_SECRET @"40288de4d89b252d9a39d69a7aa1538e"
#define SHARE_QQ_APP_KEY @"4b7b27fbc88a"
#define SHARE_QQ_APP_SECRET @"40288de4d89b252d9a39d69a7aa1538e"
#define SHARE_WE_CHAT_APP_KEY @"4b7b27fbc88a"
#define SHARE_WE_CHAT_APP_SECRET @"40288de4d89b252d9a39d69a7aa1538e"
//#define SHARE_TEXT @"我正在使用车友帮，随时随地，轻轻松松定制爱车服务，推荐你也试试！"

#define SHARE_TEXT @"Hi，亲，激活拼着玩账号，和我一起拼酒店，首次发起拼单可以获得返现，也可以邀请好友获得现金奖励!"
#define HOTELSHARE_TEXT @"和小伙伴一起拼酒店,至少可省元"
#define SHARE_URL   @"http://api.pzww.com/?uid="
#define HOTELSHARE_URL   @"http://api.pzww.com/"
//########## CACHE #################################//
#define CACHE_FOLDER_NAME  @"CheYouBangCache"

//########## weizhangchaxun #################################//
#define URL_VIOLATION_QUERIES_URL @"http://m.cheshouye.com/"

#define DEFAULTIMG @"hotelinfo_img_default.png"

#define DEFAULTHEADER @"userHeader.png"

//hql
#define CITYS @"CITYS"
#define ALLCITYS @"ALLCITYS"
#define CITYID @"CITYID"
#define CITYAREAS @"CITYAREAS"
#define SERVERDIC @"SERVERDIC"

#define APPID @"APPID"

//sort
#define SORT_AREA @"SORT_AREA"
#define SORT_ORDER @"SORT_ORDER"
#define SORT_PRICE @"SORT_PRICE"
#define SORT_STAR @"SORT_STAR"
//sort
#define TABTYPE @"TABTYPE"


#define PRICELOW @"PRICELOW"
#define MYHOTEL @"MYHOTEL"

#define USER_FIRST_LAUNCH @"USER_FIRST_LAUNCH"
#define USER_FIRST_GUID @"USER_FIRST_GUID"

#define USERDEFAULTS_CLIENT_VO_LNG @"USERDEFAULTS_CLIENT_VO_LNG"
#define USERDEFAULTS_CLIENT_VO_LAT @"USERDEFAULTS_CLIENT_VO_LAT"
#define USERDEFAULTS_CLIENT_VO_PRIVINCE @"USERDEFAULTS_CLIENT_VO_PRIVINCE"
#define USERDEFAULTS_CLIENT_VO_CITY @"USERDEFAULTS_CLIENT_VO_CITY"
#define USERDEFAULTS_CLIENT_VO_AREA @"USERDEFAULTS_CLIENT_VO_AREA"
#define USERDEFAULTS_CLIENT_VO_ADDRESS @"USERDEFAULTS_CLIENT_VO_ADDRESS"


