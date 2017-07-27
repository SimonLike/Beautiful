//
//  ShoppingCarVC.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarVC : UIViewController
@property (nonatomic, strong) IBOutlet UITableView* table;
@property (nonatomic, strong) NSMutableArray* dataAry;
@property (nonatomic, strong) IBOutlet UIButton* finishBtn;
@property (nonatomic, strong) IBOutlet UILabel* totalMoneyLabel;
@property (nonatomic, strong) IBOutlet UIButton* allBtn;
@end
