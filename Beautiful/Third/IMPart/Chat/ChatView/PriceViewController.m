//
//  PriceViewController.m
//  ChatDemo-UI2.0
//
//  Created by S on 15-6-2.
//  Copyright (c) 2015年 S. All rights reserved.
//

#import "PriceViewController.h"

@interface PriceViewController ()

@end

@implementation PriceViewController

- (void)setUI
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)saveImage:(id)sender {
    
    UIImage *image;// = [self getNormalImage:[[UIApplication sharedApplication] keyWindow]];
    image = [UIImage imageNamed:@"price"];
    //UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    NSMutableDictionary* ext = [[NSMutableDictionary alloc] init];
    [ext setValue:@"Price" forKey:@"type"];
    [ext setValue:self.timeTextField.text forKey:@"time"];
    [ext setValue:self.numTextField.text forKey:@"num"];
    [ext setValue:self.priceTextField.text forKey:@"price"];
    if (_delegate && [_delegate respondsToSelector:@selector(sendPriceImage: dic:)]) {
        [_delegate sendPriceImage:image dic:ext];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //NSLog(@"结束");
    
}

//获取当前屏幕内容



- (UIImage *)getNormalImage:(UIView *)view{
    
    
    
    //支持retina高分的关键
    
//    if(UIGraphicsBeginImageContextWithOptions != NULL)
//        
//    {
//        
//        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
//        
//    } else {
//        
//        UIGraphicsBeginImageContext(view.frame.size);
//        
//    }
    
    
    
    //获取图像
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
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
