//
//  OrderPayTypeCell.h
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OrderPayTypeCellDelegate <NSObject>

- (void)payType:(NSString*)type;

@end
@interface OrderPayTypeCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* ali;
@property (nonatomic, strong) IBOutlet UIImageView* weiChat;
@property (nonatomic, strong) IBOutlet UIImageView* uni;
@property (nonatomic, strong) id<OrderPayTypeCellDelegate>delegate;
+ (OrderPayTypeCell*)getInstanceWithNib;
- (void)setUI:(OrderVO*)vo;
@end
