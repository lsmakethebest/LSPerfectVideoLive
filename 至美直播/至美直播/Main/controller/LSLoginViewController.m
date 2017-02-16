//
//  LSLoginViewController.m
//  至美直播
//
//  Created by 刘松 on 16/10/17.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSLoginViewController.h"
#import "UMLogin.h"
#import "LSSMSLoginViewController.h"

#import "TabBarController.h"

@interface LSLoginViewController ()

@end


@implementation LSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(IBAction)login:(UIButton*)sender
{
    UMSocialPlatformType type;
      if (sender.tag==0) {
          type=UMSocialPlatformType_Sina;
    }else  if (sender.tag==1) {
        type=UMSocialPlatformType_WechatSession;
    }
    else  if (sender.tag==2) {
        
               [self presentViewController:[[UIStoryboard storyboardWithName:@"smsLogin" bundle:nil]instantiateInitialViewController] animated:YES completion:nil];
        return;
    }
    else  if (sender.tag==3) {
      type=UMSocialPlatformType_QQ;
    }
    
    [UMLogin loginWithType:type viewController:self completeHandle:^(BOOL suceess, NSString *uid, NSString *username, NSString *headicon, NSString *gender) {
        if (suceess) {
            NSMutableDictionary *params=[NSMutableDictionary dictionary];
            params[@"uid"]=uid;
            params[@"username"]=username;
            params[@"headicon"]=headicon;
            params[@"gender"]=gender;
            params[@"action"]=@"login";

            [LSHttpManager POST:@"user.php" parameters:params success:^(NSDictionary *response) {
                NSLog(@"--------%@",NSStringFromClass([response[@"code"] class]));
                if([response[@"code"] intValue]==1){
                    [UIToast showMessage:@"登录成功"];
                    [[LSUserTool sharedUserTool]saveUserInfo:  [UserModel mj_objectWithKeyValues:response[@"result"]]];
                    [UIApplication sharedApplication].keyWindow.rootViewController=[[TabBarController alloc] init];
                    
                }else{
                    [UIToast showMessage:@"登录失败"];
                }
            } failure:^(NSError *error) {
            }];
        }

        
    }];
    
   
    
    
}
@end
