//
//  AddressManageVC.h
//  Beautiful
//
//  Created by S on 16/1/26.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressManageVC : UIViewController
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* addAry;
@property (nonatomic, strong) IBOutlet UIButton* neBtn;
@end
