//
//  HomeVC.h
//  Beautiful
//
//  Created by S on 16/1/25.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLRootADSScrollView.h"
@interface HomeVC : UIViewController
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UITableView* homeTable;
@property (nonatomic, strong) NSMutableArray* recomandAry;
@property (nonatomic, strong) IBOutlet UIView* recomandView;

@property (nonatomic, strong) IBOutlet UIImageView* acImageView;

@property (nonatomic, strong) IBOutlet MLRootADSScrollView* picScrollVoew;
@property (nonatomic, strong) IBOutlet UIPageControl* imagePage;
@property (nonatomic, strong) NSMutableArray* addsArray;

@end
