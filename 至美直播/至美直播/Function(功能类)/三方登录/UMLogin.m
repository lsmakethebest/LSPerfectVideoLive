

//
//  UMLogin.m
//  至美直播
//
//  Created by 刘松 on 16/10/17.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "UMLogin.h"

@implementation UMLogin

+(void)loginWithType:(UMSocialPlatformType)platformType viewController:(UIViewController *)vc completeHandle:(UMLoginCompleteHandle)completeHandle
{
    
    //    BOOL v= [[UMSocialDataManager defaultManager] isAuth:type];
    
    //        [[UMSocialManager defaultManager]  authWithPlatform:type  currentViewController:vc completion:^(id result, NSError *error) {
    //            if(error==nil)
    //            {
    //                UMSocialAuthResponse *authresponse = result;
    //                NSString *uid=authresponse.uid;
    //
    //                [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:vc completion:^(id result, NSError *error) {
    //                    if(error==nil)
    //                    {
    //                        UMSocialUserInfoResponse *userinfo =result;
    //                        NSString *username=userinfo.name;
    //                        NSString *headicon=userinfo.iconurl;
    //                        NSString *gender=userinfo.gender;
    //                        completeHandle(YES,uid,username,headicon,gender);
    //                    }else{
    //                    completeHandle(NO,nil,nil,nil,nil);
    //                    }
    //                }];
    //            }else{
    //                completeHandle(NO,nil,nil,nil,nil);
    //            }
    //
    //        }];
    
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                completeHandle(NO,nil,nil,nil,nil);
            }else{
                if ([result isKindOfClass:[UMSocialUserInfoResponse class]]) {
                    UMSocialUserInfoResponse *userinfo = result;
                    // 第三方平台SDK源数据,具体内容视平台而定
                    //                    NSLog(@"OriginalUserProfileResponse: %@", resp.originalResponse);
                    NSString *uid=userinfo.uid;
                    NSString *username=userinfo.name;
                    NSString *headicon=userinfo.iconurl;
                    NSString *gender=userinfo.gender;
                    completeHandle(YES,uid,username,headicon,gender);
                }else{
                    completeHandle(NO,nil,nil,nil,nil);
                }
            }
        }];
    }];
    
}

+ (void)setUMAppKey {
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];
    
    
    //设置微信AppId、appSecret，分享url
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppId appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:WXAppId appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaKey appSecret:SinaSecret redirectURL:SinaRedirectURL];
    
    
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    return  [[UMSocialManager defaultManager] handleOpenURL:url];
}





@end
