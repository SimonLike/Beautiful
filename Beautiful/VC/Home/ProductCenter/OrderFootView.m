//
//  OrderFootView.m
//  Beautiful
//
//  Created by S on 16/1/29.
//  Copyright © 2016年 B. All rights reserved.
//

#import "OrderFootView.h"

@implementation OrderFootView

+ (OrderFootView*)getInstanceWithNib{
    OrderFootView *view = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"OrderFootView" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[OrderFootView class]]){
            view = (OrderFootView *)obj;
            break;
        }
    }
    return view;
}
- (void)setHeight:(NSString*)tipStr
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH, 0)];
    label.numberOfLines = 999;
    label.font = [UIFont systemFontOfSize:14];
    //NSString* str =@"交易须知：\n                                                       1、1次只能使用1张代金券，代金券金额必须低于订单总额\n2、配送方式选择后不可更换，如需更换请联系商家协调\n3、暂不支持在线退换货，如需退换货请联系商家协商\n4、支付后，15填内未确认收货，将自动确认";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tipStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:2];//调整行间距
    //[paragraphStyle setFirstLineHeadIndent:40];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tipStr length])];
    label.attributedText= attributedString;
    [label sizeToFit];
    float height = label.frame.size.height;
    _tipLabel.frame = CGRectMake(8, 12, SCREEN_WIDTH, height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
