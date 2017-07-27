/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIImageView+EMWebCache.h"
#import "EMChatImageBubbleView.h"

NSString *const kRouterEventImageBubbleTapEventName = @"kRouterEventImageBubbleTapEventName";

@interface EMChatImageBubbleView ()
@property (nonatomic, strong) UILabel *addressLabel;
@end

@implementation EMChatImageBubbleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        self.clipsToBounds = YES;
//        _addressLabel = [[UILabel alloc] init];
//        _addressLabel.font = [UIFont systemFontOfSize:LOCATION_ADDRESS_LABEL_FONT_SIZE];
//        _addressLabel.textColor = [UIColor whiteColor];
//        _addressLabel.numberOfLines = 0;
//        _addressLabel.backgroundColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:0.4];
//        _addressLabel.text = @"  花田酒店-大床房";
//        [_imageView addSubview:_addressLabel];
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize retSize;
    retSize.width = self.model.size.width;
    retSize.height = self.model.size.height;
    //HQL 调节图片显示的宽和高
    if (retSize.width == 0 || retSize.height == 0) {
        retSize.width = MAX_SIZE;
        retSize.height = MAX_SIZE;
    }
    if (retSize.width > retSize.height) {
        CGFloat height =  MAX_SIZE / retSize.width  *  retSize.height;
        retSize.height = height;
        retSize.width = MAX_SIZE;
    }else {
        CGFloat width = MAX_SIZE / retSize.height * retSize.width;
        retSize.width = width;
        retSize.height = MAX_SIZE;
    }
    int padding;
//    if(self.model.type == eMessageBodyType_Text)
//        padding = 8;
//    else
        padding = 0;
    return CGSizeMake(retSize.width + padding * 2 + BUBBLE_ARROW_WIDTH, 2 * padding + retSize.height);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    int padding;
//    if(self.model.type == eMessageBodyType_Text)
//        padding = 8;
//    else
        padding = 0;
    frame.size.width -= BUBBLE_ARROW_WIDTH;
    frame = CGRectInset(frame, padding, padding);
    if (self.model.isSender) {
        frame.origin.x = padding;
    }else{
        frame.origin.x = padding + BUBBLE_ARROW_WIDTH;
    }
    
    frame.origin.y = padding;
    [self.imageView setFrame:frame];
    _addressLabel.frame = CGRectMake(0, self.imageView.frame.size.height - 30, self.imageView.frame.size.width , 30);
    [Utils cornerView:self.imageView withRadius:3 borderWidth:1 borderColor:[UIColor clearColor]];
}

#pragma mark - setter

- (void)setModel:(MessageModel *)model
{
    [super setModel:model];
    
    UIImage *image = _model.isSender ? _model.image : _model.thumbnailImage;
    if (!image) {
        image = _model.image;
        if (!image) {
            image = [UIImage imageNamed:@"imageDownloadFail.png"];
        }
    }
    self.imageView.image = image;
}

#pragma mark - public

-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventImageBubbleTapEventName
                     userInfo:@{KMESSAGEKEY:self.model}];
}


+(CGFloat)heightForBubbleWithObject:(MessageModel *)object
{
    CGSize retSize = object.size;
    int padding;
    //if(object.type == eMessageBodyType_Text)
    //    padding = 8;
    //else
        padding = 16;
    if (retSize.width == 0 || retSize.height == 0) {
        retSize.width = MAX_SIZE;
        retSize.height = MAX_SIZE;
    }else if (retSize.width > retSize.height) {
        CGFloat height =  MAX_SIZE / retSize.width  *  retSize.height;
        retSize.height = height;
        retSize.width = MAX_SIZE;
    }else {
        CGFloat width = MAX_SIZE / retSize.height * retSize.width;
        retSize.width = width;
        retSize.height = MAX_SIZE;
    }
    return 2 * padding + retSize.height;
}

@end
