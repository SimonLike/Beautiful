//
//  AuthcodeView.h
//  Beautiful
//
//  Created by S on 16/2/2.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthcodeView : UIView

@property (strong, nonatomic) NSArray *dataArray;//字符素材数组

@property (strong, nonatomic) NSMutableString *authCodeStr;//验证码字符串
- (void)getAuthcode;
@end