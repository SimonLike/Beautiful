//
//  WebViewVC.h
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewVC : UIViewController
{
    MBProgressHUD* p_progressHUD;
}

@property (nonatomic, strong) IBOutlet UIWebView* webView;
@property (nonatomic, copy) NSString* webUrl;
@property (nonatomic, strong) RecommendVO* currentVO;
@end
