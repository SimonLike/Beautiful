//
//  OrderDetialInfoVC.h
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetialInfoVC : UIViewController
{
    UIAlertView* mAlert;
}
@property (nonatomic, strong) IBOutlet UITableView* table;
@property (nonatomic, strong) OrderVO* currentVO;
@property (nonatomic, strong) IBOutlet UIButton* paybtn;
@property (nonatomic, strong) IBOutlet UIButton* cancelBtn;
@property (nonatomic, strong) IBOutlet UIView* payView;
@end
