//
//  Utils.m
//  XQExpressCourier
//
//  Created by xf.lai on 14/8/11.
//  Copyright (c) 2014年 xf.lai. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>
#import "MarkupParser.h"
@implementation Utils


+ (void)showMSG:(NSString*)msg
{
    [JDStatusBarNotification showWithStatus:msg dismissAfter:1.5 styleName:JDStatusBarStyleDark];
}

+ (BOOL)NetStatus:(NSDictionary*)infoDic
{
    if([infoDic[@"status"] intValue] == 0)
        return YES;
    else
        return NO;
}

+ (BOOL)TokenOutDate:(NSDictionary*)infoDic
{
    if([infoDic[@"status"] intValue] == 2)
        return YES;
    else
        return NO;
}


+(void)setupRefresh:(UIScrollView*)scrollView WithDelegate:(id)delegate HeaderSelector:(SEL)headSelector FooterSelector:(SEL)footSelector
{
    if(headSelector)
    {
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:delegate refreshingAction:headSelector];
        [header setTitle:MJREFRESH_DOWN_Title1 forState:MJRefreshStateIdle];
        [header setTitle:MJREFRESH_DOWN_Title2 forState:MJRefreshStatePulling];
        [header setTitle:MJREFRESH_DOWN_Title3 forState:MJRefreshStateRefreshing];
        scrollView.mj_header = header;

    }
    if(footSelector)
    {
        MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:delegate refreshingAction:footSelector];
        [footer setTitle:MJREFRESH_UP_Title1 forState:MJRefreshStateIdle];
        [footer setTitle:MJREFRESH_UP_Title2 forState:MJRefreshStatePulling];
        [footer setTitle:MJREFRESH_UP_Title3 forState:MJRefreshStateRefreshing];
        [footer setTitle:MJREFRESH_UP_Title4 forState:MJRefreshStateNoMoreData];
        scrollView.mj_footer = footer;
    }
}


+ (NSTimeInterval)getTimeCounter:(NSString*)exStr
{
    NSDate* exDate = [Utils getDateFromStrHMS:exStr];
    //NSString* timeNow = [Utils getStrFromDate:[NSDate date]];
    //NSDate* nowDate = [Utils getDateFromStrHMS:timeNow];
    NSTimeInterval interval = [exDate timeIntervalSinceDate:[NSDate date]];
    return interval;
}

+ (NSString*)getStrFromArray:(NSMutableArray*)ary
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:ary
                                                   options:0 // non-pretty printing
                                                     error:&error];
    if(error)
        DLog(@"JSON Parsing Error: %@", error);
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (Tab_type)getTabType{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:TABTYPE] intValue];
}

//+ (UserVO*)getUserInfo{
//    return [[NSUserDefaults standardUserDefaults] valueForKey:USERINFO];
//}

+ (NSString*)getAccount{
    return [[NSUserDefaults standardUserDefaults] objectForKey:IMACCOUNT];
}

+ (NSString*)getPsw{
    return [[NSUserDefaults standardUserDefaults] objectForKey:IMPASSWORD];
}

+ (NSString*)getLat{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_CLIENT_VO_LAT];
}

+ (NSString*)getLng{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_CLIENT_VO_LNG];
}

+ (NSString*)getLoginStatue{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOGIN_STATUE];
}

+ (NSString*)getMyId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_USER_ID_KEY];
}

+ (NSString*)getMyToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_TOKEN_KEY];
}

+ (NSString*)getMyPhoneNum{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_USER_PHONE_NUM_KEY];
}

+ (BOOL)isIOSVersion7
{
    BOOL isIOS7 = NO;
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0)
    {
        isIOS7 = YES;
    }  
    return isIOS7;
}

//+ (void)archiveUserVO:(XQUserVO *)aVO {
//    if (aVO) {
//        NSMutableData *mData = [[NSMutableData alloc] init];
//        NSKeyedArchiver *myKeyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
//        [myKeyedArchiver encodeObject:aVO];
//        [myKeyedArchiver finishEncoding];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:mData forKey:USERDEFAULTS_USER_VO_KEY];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//    }
//}
//
//+ (XQUserVO*)readUnarchiveUserVO {
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_USER_VO_KEY];
//    if (!data) {
//        return nil;
//    }
//    NSKeyedUnarchiver *myKeyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    XQUserVO *uVO = [myKeyedUnarchiver decodeObject];
//    [myKeyedUnarchiver finishDecoding];
//    return uVO;
//}

+ (NetworkType)getCurrentNetworkType{
    NSNumber *numObj = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_NETWORK_KEY];
    NetworkType aType = [numObj intValue];
    return aType;
}

+ (BOOL)getBoolOfShowImgOnlyInWifi{
    NSNumber *numObj = [[NSUserDefaults standardUserDefaults]objectForKey:USERDEFAULTS_SHOW_IMG_ONLY_IN_WIFI_KEY];
    if (numObj) {
        return [numObj boolValue];
    }
    return YES;
}

+ (CGFloat)heightOfText:(NSString *)text theWidth:(float)width theFont:(UIFont*)aFont {
	CGFloat result;
	CGSize textSize = { width, 20000.0f };
    CGSize size  = CGSizeZero;
    
#ifdef IOS7_SDK_AVAILABLE
    NSDictionary *attribute =@{NSFontAttributeName: aFont};
    size = [text boundingRectWithSize:textSize
                              options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading
                           attributes:attribute
                              context:nil].size;
#else
     size = [text sizeWithFont:aFont constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
#endif
  

	result = size.height;
	return result;
}
+ (CGFloat)widthOfText:(NSString *)text theHeight:(float)height theFont:(UIFont*)aFont {
	CGFloat result;
	CGSize textSize = { 20000.0f,  height};
    CGSize size  = CGSizeZero;
    
#ifdef IOS7_SDK_AVAILABLE
    NSDictionary *attribute =@{NSFontAttributeName: aFont};
    size = [text boundingRectWithSize:textSize
                              options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading
                           attributes:attribute
                              context:nil].size;
#else
    size = [text sizeWithFont:aFont constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
#endif
    
    
	result = size.width;
	return result;
}

+ (NSString *)getDicDataByKey:(NSDictionary *)dic key:(NSString *)strKey{
    if ([dic.allKeys containsObject:strKey]) {
        return [NSString stringWithFormat:@"%@",dic[strKey]];
    }
    else return @"";
}

+(void)showTipViewWhenFailed:(NSError *)error
{
    NSString *strError = [error localizedDescription];
    if (!strError || [strError isEqualToString:@""]) {
        strError = @"Unknown error";
    }
    [[XQTipInfoView getInstanceWithNib] appear:strError];

}

+ (UIImage *)stretchableImage:(UIImage *)oriImg{
    UIImage *resultImg = [oriImg stretchableImageWithLeftCapWidth:oriImg.size.width/2. topCapHeight:oriImg.size.height/2];
    return resultImg;
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; //去掉前后空格换行符
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor redColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor redColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  //扫描16进制到int
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *) colorWithHexStringWithAlpha: (NSString *) stringToConvert Alpha:(float)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; //去掉前后空格换行符
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor redColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor redColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  //扫描16进制到int
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (void)cornerView:(UIView *)aView withRadius:(CGFloat)aR borderWidth:(CGFloat)aB borderColor:(UIColor*)aColor{
    if (aR>0.) {
        aView.layer.cornerRadius = aR;
    }
    if (aB>0.) {
        aView.layer.borderWidth = aB;
        aView.layer.borderColor = aColor.CGColor;//
    }
    aView.clipsToBounds = YES;
}

+ (void)setNavBarBgUI:(UINavigationBar*)navBar{
    navBar.barTintColor = [Utils colorWithHexString:@"24ce03"];//F54E54
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[Utils colorWithHexString:@"ffffff"],[UIFont systemFontOfSize:16],nil]
                                                      forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
    navBar.titleTextAttributes = dict;
    //navBar.barStyle=UIBarStyleDefault;
    //[navBar setTranslucent:YES];
}

+ (UIButton*)createButtonWith:(CustomButtonType)aType text:(NSString *)title{
    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (aType == CustomButtonType_Back) {
        aBtn.frame = CGRectMake(0, 0, 50, 30);
         aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        [aBtn setImage:[UIImage imageNamed:@"vps_actionbar_black_ic.png"] forState:UIControlStateNormal];
    }
    else if (aType == CustomButtonType_Back2) {
        aBtn.frame = CGRectMake(0, 0, 50, 30);
        aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        [aBtn setImage:[UIImage imageNamed:@"vps_actionbar_black_ic.png"] forState:UIControlStateNormal];
    }
    else if(aType == CustomButtonType_Text){
        [aBtn setTitle:title forState:UIControlStateNormal];
        [aBtn.titleLabel setFont:[UIFont systemFontOfSize:13.]];
        [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        aBtn.frame = CGRectMake(0, 0, 50, 30);
         aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [aBtn setBackgroundColor:[UIColor clearColor]];
        aBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        //[Utils cornerView:aBtn withRadius:4 borderWidth:1 borderColor:[UIColor whiteColor]];
    }
    else if(aType == CustomButtonType_Text2){
        [aBtn setTitle:title forState:UIControlStateNormal];
        [aBtn.titleLabel setFont:[UIFont systemFontOfSize:13.]];
        [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        aBtn.frame = CGRectMake(0, 0, 60, 30);
        aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [aBtn setBackgroundColor:[UIColor clearColor]];
        aBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        //[Utils cornerView:aBtn withRadius:4 borderWidth:1 borderColor:[UIColor whiteColor]];
    }
    else if (aType == CustomButtonType_Delete){
        [aBtn setImage:[UIImage imageNamed:@"cyb_actionbar_delete_ic.png"] forState:UIControlStateNormal];
         aBtn.frame = CGRectMake(0, 0, 50, 30);
         aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [aBtn setBackgroundColor:[UIColor clearColor]];
    }
    else if(aType == CustomButtonType_Share){
        [aBtn setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        [aBtn setImage:[UIImage imageNamed:@"share_press.png"] forState:UIControlStateHighlighted];
        aBtn.frame = CGRectMake(0, 0, 50, 30);
        aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [aBtn setBackgroundColor:[UIColor clearColor]];

    
    }
    else if(aType == CustomButtonType_Collection){
        [aBtn setImage:[UIImage imageNamed:@"hotelinfo_button_collect_default.png"] forState:UIControlStateNormal];
        aBtn.frame = CGRectMake(0, 0, 50, 30);
        aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [aBtn setBackgroundColor:[UIColor clearColor]];
        
        
    }
    else if(aType == CustomButtonType_Search){
        [aBtn setImage:[UIImage imageNamed:@"h_search.png"] forState:UIControlStateNormal];
        [aBtn setImage:[UIImage imageNamed:@"h_search_press.png"] forState:UIControlStateHighlighted];
        aBtn.frame = CGRectMake(0, 0, 50, 30);
        aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 28, 0, 0);
        [aBtn setBackgroundColor:[UIColor clearColor]];
    }
    else if(aType == CustomButtonType_Mine){
        [aBtn setImage:[UIImage imageNamed:@"nav_button_my.png"] forState:UIControlStateNormal];
        [aBtn setImage:[UIImage imageNamed:@"nav_button_my_selected.png"] forState:UIControlStateHighlighted];
        aBtn.frame = CGRectMake(0, 0, 50, 30);
        aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [aBtn setBackgroundColor:[UIColor clearColor]];
    }
    else if(aType == CustomButtonType_More){
        [aBtn setImage:[UIImage imageNamed:@"staffMore"] forState:UIControlStateNormal];
        [aBtn setImage:[UIImage imageNamed:@"staffMore"] forState:UIControlStateHighlighted];
        aBtn.frame = CGRectMake(0, 0, 50, 30);
        aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [aBtn setBackgroundColor:[UIColor clearColor]];
    }
    else if(aType == CustomButtonType_UserCenter)
    {
        //[aBtn setImage:[UIImage imageNamed:@"h_User_press.png"] forState:UIControlStateNormal];
        //[aBtn setImage:[UIImage imageNamed:@"h_User_press.png"] forState:UIControlStateHighlighted];
        aBtn.frame = CGRectMake(0, 0, 24, 24);
        aBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [aBtn setBackgroundColor:[UIColor whiteColor]];
        [Utils cornerView:aBtn withRadius:12 borderWidth:0 borderColor:[UIColor clearColor]];
    }
   // [aBtn setBackgroundColor:[UIColor redColor]];
    return aBtn;
}

+(NSString *)ret32bitString{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

//ADDED By HQL 2014/10/31
+ (NSString*)getTimeFromLongNumStrDate:(NSString*)aNumStr{
    if ([aNumStr longLongValue] == 0) {
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[aNumStr longLongValue]/1000];
    NSString * aTimeStr= [[Utils dateFormatterForDate]stringFromDate:confromTimesp];
    return aTimeStr;
}

+ (NSString*)getTimeFromLongNumStr:(NSString*)aNumStr{
    if ([aNumStr longLongValue] == 0) {
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[aNumStr longLongValue]/1000];
    NSString * aTimeStr= [[Utils dateFormatterForDateAndTime]stringFromDate:confromTimesp];
    return aTimeStr;
}
+ (NSString*)getDateFromLongNumStr:(NSString*)aNumStr{
    if ([aNumStr longLongValue] == 0) {
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[aNumStr longLongValue]/1000];
    NSString * aTimeStr= [[Utils dateFormatterForDate]stringFromDate:confromTimesp];
    return aTimeStr;
}

+ (long long)getLongNumFromDateAndTimeStr:(NSString *)aStr{
    NSDateFormatter *dateFormatter = [Utils dateFormatterForDateAndTime];
    NSDate *date = [dateFormatter dateFromString:aStr];
    long long num = [Utils getLongNumFromDate:date];//ms
   
    return num;
}
+ (long long)getLongNumFromDateStr:(NSString *)aStr{
    NSDateFormatter *dateFormatter = [Utils dateFormatterForDate];
    NSDate *date = [dateFormatter dateFromString:aStr];
    long long num = [Utils getLongNumFromDate:date];//ms
    
    return num;
}

+ (NSDate*)getDateFromStrHMS:(NSString*)aStr
{
    NSDateFormatter *dateForMatter = [Utils dateFormatterForDateAndTime];
    return [dateForMatter dateFromString:aStr];
}

+ (NSDate*)getDateFromStr:(NSString*)aStr
{
    NSDateFormatter *dateForMatter = [Utils dateFormatterForDate];
    return [dateForMatter dateFromString:aStr];
}

+ (NSDate*)getMonthDateFromStr:(NSString*)aStr
{
    NSDateFormatter *dateForMatter = [Utils monthDateFormatterForDate];
    return [dateForMatter dateFromString:aStr];
}

+ (NSString*)getStrFromDate:(NSDate*)date
{
    NSDateFormatter *dateForMatter = [Utils dateFormatterForDate];
    return [dateForMatter stringFromDate:date];
}

+ (NSString*)getMonthStrFromDate:(NSDate*)date
{
    NSDateFormatter *dateForMatter = [Utils monthDateFormatterForDate];
    return [dateForMatter stringFromDate:date];
}

+ (NSDate *)nextDay:(NSDate *)date calender:(NSCalendar*)calen space:(int)inter type:(int)Type{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if(Type == 1)
        [comps setDay:inter];
    else if(Type == 2)
        [comps setMonth:inter];
    NSDate* _date;
    _date = [calen dateByAddingComponents:comps toDate:date options:0];
    //[comps release];
    return _date;
}

+ (long long)getLongNumFromDate:(NSDate *)date{
    NSTimeInterval time = [date timeIntervalSince1970];
    // NSTimeInterval返回的是double类型，输出会显示为10位整数加小数点加一些其他值
    // 如果想转成int型，必须转成long long型才够大。
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue] ; // 将double转为long long型
    return dTime;
}
//ADDED By HQL 2014/10/31
+ (long long)getLLongNumFromDate:(NSDate *)date{
    NSTimeInterval time = [date timeIntervalSince1970];
    // NSTimeInterval返回的是double类型，输出会显示为10位整数加小数点加一些其他值
    // 如果想转成int型，必须转成long long型才够大。
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue] *1000; // 将double转为long long型
    return dTime;
}
//ADDED By HQL 2014/10/31
+ (NSDateFormatter *)dateFormatterForDateAndTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateFormatter;
}

+ (NSDateFormatter *)monthDateFormatterForDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    return dateFormatter;
}
+ (NSDateFormatter *)dateFormatterForDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return dateFormatter;
}
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

+ (NSAttributedString*)getLabelAttributedWithString:(NSString *)aStr font:(UIFont *)aFont{
    MarkupParser *parser = [[MarkupParser alloc]init];
    parser.textFont = aFont;
    NSAttributedString *attString = [parser attrStringFromMarkup:aStr];
    return attString;
}

+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:YES];
}

+ (NSString *)getImagePathWithName:(NSString *)imgName{
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);//NSDocumentDirectory
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:imgName];
     //UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return filePath;
}






//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}




+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)aSize
{
    
    if (!image) {
        return image;
    }
    CGRect aFrame = CGRectMake(0, 0, aSize.width*2, aSize.height*2);
    UIImage *newImage = image;
    CGSize imgSize = image.size;
    if (imgSize.width < aSize.width*2 || imgSize.height < aSize.height*2) {
        if (imgSize.width < aSize.width*2) {
            CGFloat scale = aSize.width*2/imgSize.width;
            newImage = [self scaleImage:image toScale:scale];
            image = newImage;
        }
        if (imgSize.height < aSize.height*2) {
            CGFloat scale = aSize.height*2/imgSize.height;
            newImage = [self scaleImage:image toScale:scale];
            image = newImage;
        }
        
    }
    else
    {
        //相对于目标size比例，原图寛大于高
        if (imgSize.width/imgSize.height > aSize.width/aSize.height) {
            CGFloat scale = aSize.height*2/imgSize.height;
            newImage = [self scaleImage:image toScale:scale];
            image = newImage;
        }
        //相对于目标size比例，原图高大于寛
        else
        {
            CGFloat scale = aSize.width*2/imgSize.width;
            newImage = [self scaleImage:image toScale:scale];
            image = newImage;
        }
        
    }
    
    
    imgSize = image.size;
    aFrame.origin.x = (imgSize.width - aSize.width*2)/2.0;
    aFrame.origin.y = (imgSize.height - aSize.height*2)/2.0;
    aFrame.size.width = aSize.width*2;
    aFrame.size.height = aSize.height*2;
    
    UIImage *rimage = [Utils croppedPhotoWithCropRect:image toFrame:aFrame];
    
    return rimage;
}

+(BOOL)judgeUrlString:(NSString *)aStr
{

    BOOL isUrl = YES;
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:aStr options:0 range:NSMakeRange(0, [aStr length])];
        if (firstMatch) {
            isUrl = YES;
            
        }else {
            //DLog(@"no result");
            isUrl = NO;
            
        }
    }
    return isUrl;
    
}



//HQL
+ (CLLocationDistance)getTheDistance:(CLLocationCoordinate2D)oriLoc DisLoc:(CLLocationCoordinate2D)dicloc
{
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:oriLoc.latitude  longitude:oriLoc.longitude];
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:dicloc.latitude longitude:dicloc.longitude];
    
    CLLocationDistance kilometers=[orig distanceFromLocation:dist];
    ////DLog(@"距离:",kilometers);
    return kilometers;
}

+ (NSString*)getCity
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_CLIENT_VO_CITY];
}

+ (CLLocationCoordinate2D)getThelocation
{
    CLLocationCoordinate2D location ;
    location.latitude = [[[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_CLIENT_VO_LAT] floatValue];
    location.longitude = [[[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_CLIENT_VO_LNG] floatValue];
    return location;
}
//

////存历史纪录数据
//+ (void)addGoodVoToHistoryData:(XQGoodsVO *)aVo{
//    NSArray *oldArys = [Utils readUnarchiveHistoryGoodsVOsAry];
//    if (!oldArys) {
//        return;
//    }
//     NSMutableArray * historyAry = [NSMutableArray arrayWithArray:oldArys];
//    [historyAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        XQGoodsVO *aHistoryVo = historyAry[idx];
//        if ([aHistoryVo.strId isEqual:aVo.strId]) {
//            [historyAry removeObject:aHistoryVo];
//            *stop = YES;
//        }
//    }];
//    [historyAry insertObject:aVo atIndex:0];
//    [Utils archiveHistoryGoodsVOsAry:historyAry];
//
//}

+ (NSArray *)readUnarchiveFacilityAry{
    NSData *oldData = [[NSUserDefaults standardUserDefaults] objectForKey:SORT_ORDER];
    if (!oldData) {
        return nil;
    }
    NSKeyedUnarchiver *myKeyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:oldData];
    NSArray *ary = [myKeyedUnarchiver decodeObject];
    [myKeyedUnarchiver finishDecoding];
    return ary;
}

+ (void)archiveFacilityAry:(NSArray *)aVOsAry{
    
    NSMutableData *newData = [[NSMutableData alloc] init];
    NSKeyedArchiver *newKeyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:newData];
    [newKeyedArchiver encodeObject:aVOsAry];
    [newKeyedArchiver finishEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:newData forKey:SORT_ORDER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (UserVO *)readUnarchiveHistoryGoodsVOsAry{
    NSData *oldData = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
    if (!oldData) {
        return nil;
    }
    NSKeyedUnarchiver *myKeyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:oldData];
    UserVO *ary = [myKeyedUnarchiver decodeObject];
    [myKeyedUnarchiver finishDecoding];
    return ary;
}

+ (void)archiveHistoryGoodsVOsAry:(UserVO *)aVOsAry{
    
    NSMutableData *newData = [[NSMutableData alloc] init];
    NSKeyedArchiver *newKeyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:newData];
    [newKeyedArchiver encodeObject:aVOsAry];
    [newKeyedArchiver finishEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:newData forKey:USERINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - ScaleImageSize
+ (UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize {
    if (image) {
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
        [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;
    }
    return nil;
}
+ (UIImage *) croppedPhotoWithCropRect:(UIImage *)aImage toFrame:(CGRect)aFrame
{
    //框的坐标
    CGRect cropRect = aFrame;
    //根据范围剪切图片得到新图片
    CGImageRef imageRef = CGImageCreateWithImageInRect([aImage CGImage], cropRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return result;
}


#pragma mark - Cache
//lxf
+  (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}
//创建缓存文件夹
+ (BOOL) createDirInCache:(NSString *)dirName
{
    NSString *imageDir = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}



// 删除图片缓存
+ (BOOL) deleteDirInCache:(NSString *)dirName
{
    NSString *imageDir = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:imageDir error:nil];
    }
    
    return isDeleted;
}

// 图片本地缓存
+ (BOOL) saveImageToCacheDir:(NSString *)directoryPath  image:(UIImage *)image imageName:(NSString *)imageName imageType:(NSString *)imageType
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    bool isSaved = false;
    if ( isDir == YES && existed == YES )
    {
        if ([[imageType lowercaseString] isEqualToString:@"png"])
        {
            isSaved = [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
        }
        else if ([[imageType lowercaseString] isEqualToString:@"jpg"] || [[imageType lowercaseString] isEqualToString:@"jpeg"])
        {
            isSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
        }
        else
        {
            //DLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", imageType);
        }
    }
    
    //NSError *error;
    //NSLog(@"图片本地缓存Documentsdirectory: %@",[fileManager contentsOfDirectoryAtPath:directoryPath error:&error]);
    
    return isSaved;
}
// 获取缓存图片
+ (NSData*) loadImageData:(NSString *)directoryPath imageName:( NSString *)imageName
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( isDir == YES && dirExisted == YES )
    {
        NSString *imagePath = [directoryPath stringByAppendingString : [NSString stringWithFormat:@"/%@",imageName]];
        BOOL fileExisted = [fileManager fileExistsAtPath:imagePath];
        if (!fileExisted) {
            return NULL;
        }
        NSData *imageData = [NSData dataWithContentsOfFile : imagePath];
        return imageData;
    }
    else
    {
        return NULL;
    }
}
//lxf
+ (BOOL)deleteAllImageCache{
    // 删除所有图片缓存
    NSString *path = [self pathInCacheDirectory:CACHE_FOLDER_NAME];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    bool isDeleted = false;
    //NSError *error;
    //NSLog(@"111Documentsdirectory: %@",[fileManager contentsOfDirectoryAtPath:path error:&error]);
    
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:path error:nil];
    }
    
    //NSLog(@"222Documentsdirectory: %@",[fileManager contentsOfDirectoryAtPath:path error:&error]);
    
    return isDeleted;
}

@end
