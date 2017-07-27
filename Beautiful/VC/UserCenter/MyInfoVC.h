//
//  MyInfoVC.h
//  Manage
//
//  Created by S on 15/12/22.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "DAProgressOverlayView.h"
@interface MyInfoVC : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *p_imagePicker;
    DAProgressOverlayView *p_progressOverlayView;
    NSTimer *p_timer;
}
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@end
