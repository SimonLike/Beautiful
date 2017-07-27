//
//  InfoModifyVC.m
//  Manage
//
//  Created by S on 15/12/22.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "InfoModifyVC.h"

@interface InfoModifyVC ()

@end

@implementation InfoModifyVC

- (void)setUI
{
    //self.title = @"我要装修";
    [Utils setNavBarBgUI:self.navigationController.navigationBar];
    self.view.backgroundColor = [Utils colorWithHexString:@"f0f2f5"];
    
    UIButton* backBtn = [Utils createButtonWith:CustomButtonType_Back text:nil];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton* saveBtn = [Utils createButtonWith:CustomButtonType_Text text:nil];
    [saveBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    if([self.type isEqualToString:@"1"])
    {
        self.tipLabel.text = @"昵称";
        self.title = @"修改昵称";
        self.textInput.placeholder = @"请输入昵称";
        self.textInput.text = [Utils readUnarchiveHistoryGoodsVOsAry].username;
    }
    else
    {
        self.tipLabel.text = @"地址";
        self.title = @"施工地址";
        self.textInput.placeholder = @"请输入施工地址";
        //self.textInput.text = [Utils readUnarchiveHistoryGoodsVOsAry].address;
    }
}

- (IBAction)save:(id)sender
{
    if([self.textInput.text isEqualToString:@""])
    {
        TTAlert(@"请输入修改信息");
        return;
    }
    if([self.type isEqualToString:@"1"])
    {
        [[NetWork shareInstance] UserInfo:[Utils readUnarchiveHistoryGoodsVOsAry].token IconUrl:[Utils readUnarchiveHistoryGoodsVOsAry].iconUrl Name:_textInput.text Address:@"" CompanyId:@"" CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                [[XQTipInfoView getInstanceWithNib] appear:@"保存成功"];
                UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
                uVO.username = _textInput.text;
                [Utils archiveHistoryGoodsVOsAry:uVO];
                [self clickBack:nil];
            }
        } FailBack:^(NSError *error) {
            
        }];
    }
    else
    {
//        [[NetWork shareInstance] UserInfo:[Utils readUnarchiveHistoryGoodsVOsAry].token IconUrl:[Utils readUnarchiveHistoryGoodsVOsAry].iconUrl Name:[Utils readUnarchiveHistoryGoodsVOsAry].name Address:_textInput.text CompanyId:[Utils readUnarchiveHistoryGoodsVOsAry].companyId callBack:^(MKNetworkOperation *completedOperation) {
//            NSError *error;
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[completedOperation responseData] options:NSJSONReadingMutableLeaves error:&error];
//            //这里可能会加入错误码的判断
//            if (!error)
//            {
//                if([dic[@"status"] intValue] == 0)
//                {
//                    [[XQTipInfoView getInstanceWithNib] appear:@"保存成功"];
//                    UserVO* uVO = [Utils readUnarchiveHistoryGoodsVOsAry];
//                    uVO.address = _textInput.text;
//                    [Utils archiveHistoryGoodsVOsAry:uVO];
//                    [self clickBack:nil];
//                }
//                else
//                {
//                    [[XQTipInfoView getInstanceWithNib] appear:dic[@"msg"]];
//                }
//            }
//            else
//            {
//                [[XQTipInfoView getInstanceWithNib] appear:@"网络错误"];
//                
//            }
//        }];
    }
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textInput resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textInput resignFirstResponder];
    return YES;
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
