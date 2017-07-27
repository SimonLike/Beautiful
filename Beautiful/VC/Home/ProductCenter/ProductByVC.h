//
//  ProductByVC.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductByVC : UIViewController
{
    UIAlertView* mAlert;
}
@property (nonatomic, strong) IBOutlet UITableView* table;
@property (nonatomic, strong) OrderVO* currentVO;
@property (nonatomic, strong) IBOutlet UILabel* totalPay;
@property (nonatomic, strong) NSString* channel;
@end
