//
//  LSSMSLoginViewController.m
//  至美直播
//
//  Created by 刘松 on 16/10/17.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSSMSLoginViewController.h"

#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>
#import "TabBarController.h"

#import "LSPhoneTextField.h"

@interface LSSMSLoginViewController ()
@property (nonatomic,weak) IBOutlet LSPhoneTextField *phone;

@property (nonatomic,weak) IBOutlet UITextField *code;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@end

@implementation LSSMSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"登录";
    self.codeButton.radius=3;
    [self.codeButton setBackgroundImage:[UIImage imageNamed:@"blueBackDisabled"] forState:UIControlStateDisabled];
    [self.codeButton setBackgroundImage:[UIImage imageNamed:@"blueBack"] forState:UIControlStateNormal];
    [self.codeButton setBackgroundImage:[UIImage imageNamed:@"blueBackHighlighted"] forState:UIControlStateHighlighted];
    WeakSelf;
    self.phone.block=^(BOOL completed){
        if (!weakSelf.codeButton.ls_countDowning) {
            weakSelf.codeButton.enabled=completed;
        }
    };
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"关闭" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancel)];
    
}
-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)login
{
    
    NSLog(@"2222222222222");
    [LSStatusBarHUD showLoading:@"登录中"];
    [SMSSDK commitVerificationCode:self.code.text phoneNumber:self.phone.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
    
        
        if (error==nil) {
                NSMutableDictionary *params=[NSMutableDictionary dictionary];
                params[@"mobile"]=self.phone.text;
                params[@"action"]=@"login";
            
            [LSHttpManager POST:@"user.php" parameters:params success:^(NSDictionary *response) {
                NSLog(@"--------%@",NSStringFromClass([response[@"code"] class]));
                if([response[@"code"] intValue]==1){
                    NSLog(@"登录成功");
                    [LSStatusBarHUD showMessage:@"登录成功"];
                    [[LSUserTool sharedUserTool]saveUserInfo:  [UserModel mj_objectWithKeyValues:response[@"result"]]];
                    [UIApplication sharedApplication].keyWindow.rootViewController=[[TabBarController alloc] init];
                    
                }else{
                    NSLog(@"登录失败");
                    [LSStatusBarHUD showMessage:@"登录失败"];
                }

            } failure:^(NSError *error) {
                
            }];
            
        }else{
            NSLog(@"1111111111111111");
            [LSStatusBarHUD showMessage:@"验证码错误"];
        }
    }];

    
}

- (IBAction)switchCounty:(id)sender {
    
    
    [UIToast showMessage:@"选择国家"];
    
}


- (IBAction)getCode:(UIButton*)sender
{
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phone.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error)
     {
         if (error==nil) {
             [sender ls_startCountWithTime:60 subTitle:@"s" disabledColor:[UIColor whiteColor]];
             [LSStatusBarHUD showMessage:@"发送成功"];
         }else{
//              [LSStatusBarHUD showMessage:@"登录失败"];
             [LSStatusBarHUD showMessage:error.userInfo[@"getVerificationCode"]];
         }
         
     }];
    
    
}




@end
