//
//  AppointDetialVC.h
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLRootADSScrollView.h"
@interface AppointServiceDetialVC : UIViewController
{
    MBProgressHUD* p_progressHUD;
}
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet MLRootADSScrollView* picScrollVoew;
@property (nonatomic, strong) IBOutlet UIView* picNumBgView;
@property (nonatomic, strong) IBOutlet UILabel* picNum;
@property (nonatomic, strong) IBOutlet UILabel* titleLael;
@property (nonatomic, strong) IBOutlet UILabel* perPrice;
@property (nonatomic, strong) IBOutlet UILabel* saleNum;
@property (nonatomic, strong) NSMutableArray* addsArray;
@property (nonatomic, strong) ProductDetialVO* currentVO;
@property (nonatomic, strong) ProductVO* currentpVO;
@property (nonatomic, strong) IBOutlet UIWebView* webView;
@property (nonatomic, strong) IBOutlet UIButton* appointBtn;
@end
