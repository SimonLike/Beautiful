//
//  NALScanViewController.m
//  NorthAmericanLive
//
//  Created by Yang on 16/1/28.
//  Copyright © 2016年 NorthAmericanLive. All rights reserved.
//

#import "NALScanViewController.h"
#import "UIButton+EnlargeArea.h"
#import "ProductDetialVC.h"
@interface NALScanViewController ()

@end

@implementation NALScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"扫一扫";
    self.navigationController.navigationBarHidden = NO;
    
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 3;
    
    style.colorAngle = [UIColor greenColor];
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"qrcode_scan_light_green.png"];
    
    self.style = style;
    
    self.title = @"二维码扫描";
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    UIButton* searchBtn = [Utils createButtonWith:CustomButtonType_Text text:@"相册"];
    //[searchBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    //    if([[Utils readUnarchiveHistoryGoodsVOsAry].role isEqualToString:@"1"])
    //    {
    //        [searchBtn setImage:[UIImage imageNamed:@"h_Info.png"] forState:UIControlStateNormal];
    //        [searchBtn setImage:[UIImage imageNamed:@"h_Info_Press.png"] forState:UIControlStateHighlighted];
    //        self.fitLabel.text = @"装修单";
    //        self.fixLabel.text = @"报修单";
    //    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [searchBtn addTarget:self action:@selector(btnPhotoClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    _lbAlert = [[UILabel alloc]initWithFrame:CGRectMake(10, self.view.center.y + 30, SCREEN_WIDTH-20, 35)];
//    _lbAlert.backgroundColor = [UIColor clearColor];
//    _lbAlert.textColor = [UIColor whiteColor];
//    _lbAlert.font = [UIFont systemFontOfSize:15];
//    _lbAlert.lineBreakMode = NSLineBreakByWordWrapping;
//    _lbAlert.numberOfLines = 0;
//    _lbAlert.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_lbAlert];
//    _lbAlert.text = @"将二维码/条形码放置框内,即可自动扫描";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnPhotoClicked:(UIButton *)button{
    // 跳转到相册页面
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.allowsEditing = YES;
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    
//    [self presentViewController:imagePickerController animated:YES completion:^{
//        
//    }];
    if ([LBXScanWrapper isGetPhotoPermission])
        [self openLocalPhoto];
    else
    {
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
    }
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    
    if (array.count < 1)
    {
        TTAlert(@"未发现二维码");
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString *strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        //_lbAlert.text = @"未发现二维码/条码";
        //[self performSelector:@selector(showUploadGoodsVC) withObject:nil afterDelay:2];
        
        //return;
        TTAlert(@"未发现二维码");
        return;
    }
    
    //声音提醒
    [LBXScanWrapper systemSound];
    
    
    
    
//    [[NetWork shareInstance] productDetial:strResult callBack:^(MKNetworkOperation *completedOperation) {
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//        //这里可能会加入错误码的判断
//        if (!error)
//        {
//            if([dic[@"status"] intValue] == 0)
//            {
//                ProductDetialVO* vo = [ProductDetialVO objectWithKeyValues:dic[@"data"]];
//                ProductDetialVC* vc = [[ProductDetialVC alloc] initWithNibName:@"ProductDetialVC" bundle:nil];
//                vc.currentVO = vo;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//            else
//            {
//                [[XQTipInfoView getInstanceWithNib] appear:dic[@"msg"]];
//                [self back];
//            }
//        }
//        else
//        {
//            [[XQTipInfoView getInstanceWithNib] appear:@"网络错误"];
//            [self back];
//            
//        }
//    }failBack:^(MKNetworkOperation *completedOperation) {
//        [self back];
//    }];

    
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"扫码结果" message:strResult delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//    [alert show];
    
}

- (void)showUploadGoodsVC{
    
}
@end
