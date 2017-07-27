//
//  OrderCenterVC.h
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLRootADSScrollView.h"
@interface OrderCenterVC : UIViewController
{
    UIAlertView* mAlert;
}
@property (nonatomic, strong) IBOutlet MLRootADSScrollView* fCScrollView;
@property (nonatomic, strong) IBOutlet UIView* tipView;
@property (nonatomic, assign) OrderType orderType;
@property (nonatomic, strong) IBOutlet UILabel* waitingLabel;
@property (nonatomic, strong) IBOutlet UILabel* ingLabel;
@property (nonatomic, strong) IBOutlet UILabel* overLabel;
@property (nonatomic, assign) int ViewType;
@property (nonatomic, strong) NSMutableArray* waitAry;
@property (nonatomic, strong) NSMutableArray* ingAry;
@property (nonatomic, strong) NSMutableArray* overAry;
@property (nonatomic, strong) NSMutableArray* finishAry;
@end
