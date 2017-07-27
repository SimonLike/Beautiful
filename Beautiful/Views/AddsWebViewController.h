//
//  AddsWebViewController.h
//  PZWToGetHer
//
//  Created by S on 15-2-9.
//
//

#import <UIKit/UIKit.h>

@interface AddsWebViewController : UIViewController
{
    MBProgressHUD* p_progressHUD;
}
@property (nonatomic, strong) IBOutlet UIWebView* webView;
@property (nonatomic, copy) NSString* webUrl;
@end
