//
//  WaitPayCell.h
//  Beautiful
//
//  Created by S on 16/2/1.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceDayView.h"
@protocol WaitPayCellDelegate <NSObject>

- (void)payNow:(UITableViewCell*)cell;
- (void)getNow:(UITableViewCell*)cell;
- (void)cancelNow:(UITableViewCell*)cell;
@end

@interface WaitPayCell : UITableViewCell<PriceDayViewDelegate>
@property (nonatomic, strong) IBOutlet UIButton* paybtn;
@property (nonatomic, strong) IBOutlet UIButton* cancelBtn;
@property (nonatomic, strong) id<WaitPayCellDelegate>delegate;
@property (nonatomic, strong) NSString* status;
+ (WaitPayCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)oVO;
@end
