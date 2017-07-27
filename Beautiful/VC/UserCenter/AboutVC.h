//
//  AboutVC.h
//  Manage
//
//  Created by S on 15/12/16.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutVC : UIViewController
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIView* logoView;
@property (nonatomic, strong) IBOutlet UIView* InfoView;
@property (nonatomic, strong) IBOutlet UILabel* versionLabel;
@property (nonatomic, strong) IBOutlet UILabel* infoLabel;
@end
