//
//  MyInfoVC.m
//  Manage
//
//  Created by S on 15/12/22.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "MyInfoVC.h"
#import "InfoModifyVC.h"
#import "MofifyPSWVC.h"
#import "AppDelegate.h"
#import "ImgConfigVC.h"
#import "AddressManageVC.h"
//static void *HQLRefreshKey = @"HQLKey";
static NSString *kAvataName = @"avata.png";

@interface MyInfoVC ()
{
    UIImageView* img;
}
@end

@implementation MyInfoVC

- (void)setUI
{
    self.title = @"我的资料";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50-40, 15, 50, 50)];
}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = nil;
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.tableView reloadData];
    //[MobClick beginLogPageView:@"UserInfoCenter"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[MobClick endLogPageView:@"UserInfoCenter"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //if(![Utils readUnarchiveHistoryGoodsVOsAry])
    //    [self test];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
    return vv;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vv = [[UIView alloc]init];
    vv.backgroundColor = [UIColor clearColor];
//    if(section == 2)
//    {
//        vv.frame = CGRectMake(0, 0, 320, 100);
//        UIButton* loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 50, 260, 42)];
//        loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [loginOutBtn setTitleColor:[Utils colorWithHexString:@"535353"] forState:UIControlStateNormal];
//        loginOutBtn.backgroundColor = [Utils colorWithHexString:@"dddddd"];
//        [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//        [loginOutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
//        [vv addSubview:loginOutBtn];
//        [Utils cornerView:loginOutBtn withRadius:3 borderWidth:0 borderColor:[UIColor clearColor]];
//    }
    return vv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0)
                return 80;
            else
                return 56;
            break;
        default:
            return 56;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
    static NSString *cellIdentifier = @"Key";
    UITableViewCell *cell = [tableView   dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 56)];
    UILabel* detialLabel;
    
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textColor = [Utils colorWithHexString:@"535353"];
    //UIView* TopLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    //TopLine.backgroundColor = [Utils colorWithHexString:@"dddddd"];
    
    //UIView* bottowLine = [[UIView alloc] initWithFrame:CGRectMake(15, 55, 305, 1)];
    //bottowLine.backgroundColor = [Utils colorWithHexString:@"dddddd"];
    detialLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40-125, 0, 125, 56)];
    detialLabel.textAlignment = NSTextAlignmentRight;
    detialLabel.textColor = [UIColor lightGrayColor];
    detialLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    [img sd_setImageWithURL:[NSURL URLWithString:[Utils readUnarchiveHistoryGoodsVOsAry].iconUrl] placeholderImage:[UIImage imageNamed:@"defaulthead.png"]];
                    titleLabel.text = @"头像";
                    titleLabel.frame = CGRectMake(15, 0, 100, 80);
                    [cell.contentView addSubview:img];
                    [Utils cornerView:img withRadius:25 borderWidth:0 borderColor:[UIColor clearColor]];
                }
                    break;
                case 1:
                {
                    //img.image = [UIImage imageNamed:@"m_fitIcon.png"];
                    titleLabel.text = @"昵称";
                    detialLabel.text = uVO.username;
                }
                    break;
                case 2:
                {
                    //img.image = [UIImage imageNamed:@"m_fitIcon.png"];
                    titleLabel.text = @"手机号";
                    detialLabel.text = uVO.phone;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (row) {
                case 0:
                {
                    titleLabel.text = @"地址管理";
                }
                    break;
                case 1:
                {
                    titleLabel.text = @"修改密码";
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        default:
            break;
    }
    
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:detialLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    id vc;
    
    switch (section) {
        case 0:
            switch (row) {
                case 0:
                {
                    [self Icon];
                }
                    break;
                case 1:
                    vc = [[InfoModifyVC alloc] initWithNibName:@"InfoModifyVC" bundle:nil];
                    ((InfoModifyVC*)vc).type = @"1";
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                case 2:
                    vc = [[ImgConfigVC alloc] initWithNibName:@"ImgConfigVC" bundle:nil];
                    ((ImgConfigVC*)vc).imgType = @"2";
                    ((ImgConfigVC*)vc).title = @"修改手机号";
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (row) {
                case 0:
                {
                    vc = [[AddressManageVC alloc] initWithNibName:@"AddressManageVC" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    if ([Utils readUnarchiveHistoryGoodsVOsAry].phone.length<11)
                    {
                        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"绑定手机后才能进行密码修改！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                        [alerView show];
                    }
                    else
                    {
                        vc = [[MofifyPSWVC alloc] initWithNibName:@"MofifyPSWVC" bundle:nil];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                    break;
                }
                    
                default:
                    break;
            }
            break;
        default:
            break;
    }
    //加入选择事件
}

- (void)Icon
{
    
    //[[XQTipInfoView getInstanceWithNib] appear:@"接口出来就可以用了"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                             delegate:self
                                    cancelButtonTitle:@"取消"
                               destructiveButtonTitle:@"本地上传"
                                    otherButtonTitles:@"拍照上传", nil];
    
//    void (^actionSheetBlock)(NSInteger) = ^(NSInteger buttonIndex){
//        
//        //                        else if(buttonIndex == 1){
//        //                            [self pickImageFromAlbum];
//        //
//        //                        }
//    };
//    objc_setAssociatedObject(actionSheet, HQLRefreshKey, actionSheetBlock, OBJC_ASSOCIATION_COPY);
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self pickImageFromAlbum];
    }
    else if(buttonIndex == 1){
        [self pickImageFromCamera];
        
    }
}

#pragma mark -
- (void)pickImageFromCamera
{
    //判断是否有相机
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        return;
    }
    if (!p_imagePicker) {
        p_imagePicker = [[UIImagePickerController alloc] init];
        p_imagePicker.delegate = self;
        p_imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        p_imagePicker.allowsEditing = YES;
        
        
    }
    p_imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:p_imagePicker animated:YES completion:nil];
    
}

- (void)pickImageFromAlbum
{
    if (!p_imagePicker) {
        p_imagePicker = [[UIImagePickerController alloc] init];
        p_imagePicker.delegate = self;
        p_imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        p_imagePicker.allowsEditing = YES;
        [Utils setNavBarBgUI:p_imagePicker.navigationBar];
        
    }
    p_imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:p_imagePicker animated:YES completion:nil];
}

#pragma mark - upload avatar
- (void)uploadAvatar:(UIImage *)image{
    //_registerBtn.enabled = NO;
    
    NSString *avaterPath = [Utils getImagePathWithName:kAvataName];
    UIImage *avata = [UIImage imageWithContentsOfFile:avaterPath];
    if (avata) {
        
        [img setImage:image];
        if (!p_progressOverlayView) {
            p_progressOverlayView = [[DAProgressOverlayView alloc] initWithFrame:img.bounds];
            [img addSubview:p_progressOverlayView];
            [p_progressOverlayView displayOperationWillTriggerAnimation];
        }
        p_progressOverlayView.hidden = NO;
        double delayInSeconds = p_progressOverlayView.stateChangeAnimationDuration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            
            //这里上传头像
            [XQUploadHelper startSendImageName:@"file" image:image parameters:[NSDictionary dictionary] block:^(NSData *obj, id error) {
                NSLog(@"data:%@",[[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding]);
                if (!error)
                {
                    NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
                    NSString *url = dic[@"data"][@"url"];
                    
                    [[NetWork shareInstance] UserInfo:[Utils readUnarchiveHistoryGoodsVOsAry].token IconUrl:url Name:[Utils readUnarchiveHistoryGoodsVOsAry].username Address:@"" CompanyId:@"" CallBack:^(BOOL isSucc, NSDictionary *info) {
                        [[XQTipInfoView getInstanceWithNib] appear:@"保存成功"];
                        UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
                        uVO.iconUrl = url;
                        [Utils archiveHistoryGoodsVOsAry:uVO];
                        [_tableView reloadData];
                        //
                    } FailBack:^(NSError *error) {
                        //
                    }];
                    
                }
                else
                    [[XQTipInfoView getInstanceWithNib]appear:@"上传失败"];
            }];
            
            p_timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        });
        
    }
    
    
//    //self.avataImgView.image = image;
//    NSString *avaterPath = [Utils getImagePathWithName:kAvataName];
//    UIImage *avata = [UIImage imageWithContentsOfFile:avaterPath];
//    if (avata) {
//        XQUploadHelper *helper = [[XQUploadHelper alloc]init];
//        [helper uploadWithType:UploadType_member
//                       imgPath:avaterPath
//                      imgArray:nil
//                 progressBlock:nil
//                 sucessedBlock:^(NSString *urlStr) {
//                    
//                     [[NetWork shareInstance] UserInfo:[Utils readUnarchiveHistoryGoodsVOsAry].token IconUrl:urlStr Name:[Utils readUnarchiveHistoryGoodsVOsAry].username Address:@"" CompanyId:@"" CallBack:^(BOOL isSucc, NSDictionary *info) {
//                         if(isSucc)
//                         {
//                             [[XQTipInfoView getInstanceWithNib] appear:@"保存成功"];
//                             
//                             UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
//                             uVO.iconUrl = urlStr;
//                             [Utils archiveHistoryGoodsVOsAry:uVO];
//                             
//                             [img setImage:image];
//                             if (!p_progressOverlayView) {
//                                 p_progressOverlayView = [[DAProgressOverlayView alloc] initWithFrame:img.bounds];
//                                 [img addSubview:p_progressOverlayView];
//                                 [p_progressOverlayView displayOperationWillTriggerAnimation];
//                                 
//                             }
//                             p_progressOverlayView.hidden = NO;
//                             double delayInSeconds = p_progressOverlayView.stateChangeAnimationDuration;
//                             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//                             dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
//                                 
//                                 //这里上传头像
//                                 
//                                 
//                                 p_timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
//                             });
//                         }
//                     } FailBack:^(NSError *error) {
//                         
//                     }];
//                 } failedBlock:^(NSString *strStatus) {
//                     [[XQTipInfoView getInstanceWithNib]appear:@"上传失败"];
//                     //[p_avataImgView setImageWithURL:[NSURL URLWithString:p_newVo.strAvataUrl]];
//                     
//                 }];
//        
//    }
}

- (void)updateProgress
{
    CGFloat progress = p_progressOverlayView.progress + 0.01;
    if (progress >= 1) {
        [p_timer invalidate];
        [p_progressOverlayView displayOperationDidFinishAnimation];
        double delayInSeconds = p_progressOverlayView.stateChangeAnimationDuration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            p_progressOverlayView.progress = 0.;
            p_progressOverlayView.hidden = YES;
            //_registerBtn.enabled = YES;
        });
    } else {
        p_progressOverlayView.progress = progress;
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    image = [Utils imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
    [Utils saveImage:image WithName:kAvataName];
    [self uploadAvatar:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}


- (void)loginOut
{
    [[NetWork shareInstance] loginOut:[Utils readUnarchiveHistoryGoodsVOsAry].token CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            [[XQTipInfoView getInstanceWithNib]appear:@"操作成功"];
            //退出登录
            [[NSUserDefaults standardUserDefaults] setObject:LOGINOUT forKey:USER_LOGIN_STATUE];
            UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
            uVO.token = @"";
            [Utils archiveHistoryGoodsVOsAry:uVO];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [(AppDelegate*)MyAppDelegate switchLoginStatus];
        }
    } FailBack:^(NSError *error) {
        
    }];
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
