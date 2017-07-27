//
//  PriceViewController.h
//  ChatDemo-UI2.0
//
//  Created by S on 15-6-2.
//  Copyright (c) 2015年 S. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceViewDelegate <NSObject>

- (void)sendPriceImage:(UIImage*)orgImage dic:(NSDictionary*)ext;

@end

@interface PriceViewController : UIViewController
@property (nonatomic, assign) id<PriceViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITextField* timeTextField;
@property (nonatomic, strong) IBOutlet UITextField* numTextField;
@property (nonatomic, strong) IBOutlet UITextField* priceTextField;
@end
