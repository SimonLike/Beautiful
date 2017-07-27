//
//  AddsWebViewController.m
//  PZWToGetHer
//
//  Created by S on 15-2-9.
//
//

#import "AddsWebViewController.h"

@interface AddsWebViewController ()

@end

@implementation AddsWebViewController

- (void)setUI{
    //self.title = @"酒店详情";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    UIButton *leftBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [leftBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_RESET_TABBAR object:[NSNumber numberWithBool:YES]];
//    [Utils setNavBarBgUI:self.navigationController.navigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
    p_progressHUD  = [[MBProgressHUD alloc] initWithView:self.view];
    p_progressHUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:p_progressHUD];
    [p_progressHUD show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    p_progressHUD.hidden = YES;
    [p_progressHUD removeFromSuperview];
    p_progressHUD = nil;
    //[[XQTipInfoView getInstanceWithNib] appear:@"链接地址错误"];
    //[self clickBack:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
