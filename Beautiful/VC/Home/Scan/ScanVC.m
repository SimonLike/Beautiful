//
//  ScanVC.m
//  Beautiful
//
//  Created by S on 16/1/27.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ScanVC.h"

@interface ScanVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property ( strong , nonatomic ) AVCaptureDevice * device;

@property ( strong , nonatomic ) AVCaptureDeviceInput * input;

@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;

@property ( strong , nonatomic ) AVCaptureSession * session;

@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * preview;

@end

@implementation ScanVC

- (void)setUI
{
    self.title = @"二维码扫描";
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    
    
    // Device
    
    _device = [ AVCaptureDevice defaultDeviceWithMediaType : AVMediaTypeVideo ];
    
    // Input
    
    _input = [ AVCaptureDeviceInput deviceInputWithDevice : self . device error : nil ];
    
    // Output
    
    _output = [[ AVCaptureMetadataOutput alloc ] init ];
    
    [ _output setMetadataObjectsDelegate : self queue : dispatch_get_main_queue ()];
    
    // Session
    
    _session = [[ AVCaptureSession alloc ] init ];
    
    [ _session setSessionPreset : AVCaptureSessionPresetHigh ];
    
    if ([ _session canAddInput : self . input ])
        
    {
        
        [ _session addInput : self . input ];
        
    }
    
    if ([ _session canAddOutput : self . output ])
        
    {
        
        [ _session addOutput : self . output ];
        
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    
    _output . metadataObjectTypes = @[ AVMetadataObjectTypeQRCode ] ;
    [ _output setRectOfInterest : CGRectMake (( (SCREEN_HEIGHT-220)/2 )/ SCREEN_HEIGHT ,(( SCREEN_WIDTH - 220 )/ 2 )/ SCREEN_WIDTH , 220 / SCREEN_HEIGHT , 220 / SCREEN_WIDTH )];
    // Preview
    
    _preview =[ AVCaptureVideoPreviewLayer layerWithSession : _session ];
    
    _preview . videoGravity = AVLayerVideoGravityResizeAspectFill ;
    
    _preview . frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);//self . view . layer . bounds ;
    
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-220)/2, (SCREEN_HEIGHT-220)/2, 220, 220)];
    //bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.];
    [Utils cornerView:bgView withRadius:0 borderWidth:1 borderColor:[Utils colorWithHexString:@"FA6767"]];
    [ self . view . layer insertSublayer : _preview atIndex : 0 ];
    //[ self . view . layer insertSublayer : bgView.layer atIndex : 0 ];
    [self.view addSubview:bgView];
    // Start
    
    [ _session startRunning ];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [ _session startRunning ];
}

- (void)viewWillDisAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [ _session stopRunning ];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- ( void )captureOutput:( AVCaptureOutput *)captureOutput didOutputMetadataObjects:( NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection

{
    
    NSString *stringValue;
    
    if ([metadataObjects count ] > 0 )
        
    {
        
        // 停止扫描
        
        [ _session stopRunning ];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        
        stringValue = metadataObject. stringValue ;
        [[XQTipInfoView getInstanceWithNib] appear:stringValue];
        NSLog(@"%@",stringValue);
//        MyFriVO* mVO = [[MyFriVO alloc] init];
//        mVO.strUserID = stringValue;
//        mVO.strIconUrl = @"";
//        FIMyFriDetialVC*  vc = [[FIMyFriDetialVC alloc] initWithNibName:@"FIMyFriDetialVC" bundle:nil];
//        vc.currentAccount = stringValue;
//        vc.currentMVO = mVO;
//        //vc.isMyfri = 0;
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
