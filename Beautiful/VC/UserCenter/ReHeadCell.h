//
//  ReHeadCell.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReHeadCellDelegate <NSObject>

- (void)weiChat;
- (void)weiChatTimeLine;
- (void)sina;
- (void)QQ;
- (void)copyCode;
@end
@interface ReHeadCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* codeLabel;
@property (nonatomic, strong) id<ReHeadCellDelegate>delegate;
+ (ReHeadCell*)getInstanceWithNib;
- (void)setUI:(NSString*)card;
@end
