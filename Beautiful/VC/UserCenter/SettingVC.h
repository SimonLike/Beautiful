//
//  SettingVC.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingVC : UIViewController
{
    MBProgressHUD* p_progressHUD;
}
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@end
