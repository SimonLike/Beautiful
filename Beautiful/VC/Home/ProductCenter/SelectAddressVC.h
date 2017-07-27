//
//  SelectAddressVC.h
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
//回掉代码块
typedef void (^OderBlock)(AddressVO *model);
@interface SelectAddressVC : UIViewController
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* addAry;
@property (nonatomic, strong) OderBlock orderBlock;
@end
