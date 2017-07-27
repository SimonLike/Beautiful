//
//  AppointDetialVC.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointDetialVC : UIViewController
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) AppointVO* currentVO;
@property (nonatomic, strong) IBOutlet UIImageView* icon;
@property (nonatomic, strong) IBOutlet UILabel* titleLabel;
@property (nonatomic, strong) IBOutlet UILabel* perPrice;
@property (nonatomic, strong) IBOutlet UILabel* totalMoney;
@property (nonatomic, strong) IBOutlet UILabel* payMoney;
@property (nonatomic, strong) IBOutlet UILabel* appointTime;
@property (weak, nonatomic) IBOutlet UILabel *leftNumLabel;


@property (nonatomic, strong) IBOutlet UILabel* status;
@property (nonatomic, strong) IBOutlet UILabel* appointNum;
@property (nonatomic, strong) IBOutlet UILabel* createTime;
@property (nonatomic, strong) IBOutlet UILabel* payTime;
@property (nonatomic, strong) IBOutlet UILabel* payType;
@property (nonatomic, strong) IBOutlet UILabel* paySale;
@end
