

//
//  UMShare.m
//  driver
//
//  Created by 刘松 on 16/8/4.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "UMShare.h"
@implementation UMShare

//+ (void)setUMAppKey {

    
    
//    
//    //打开调试日志
//    [[UMSocialManager defaultManager] openLog:YES];
//    
//    //设置友盟appkey
//    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];
//    
//    
//  //设置微信AppId、appSecret，分享url
//
//    //设置微信的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppId appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
//   
//     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:WXAppId appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
//    
//    
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID appSecret:QQKey redirectURL:@"http://mobile.umeng.com/social"];
//    
//
//  //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要
//  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaKey appSecret:SinaSecret redirectURL:SinaRedirectURL];
//    
//
//}
//
//+ (void)shareWithType:(UMSocialPlatformType)type
//                title:(NSString *)title
//             shareURL:(NSString *)shareURL
//           shareImage:(UIImage *)shareImage
//            shareText:(NSString *)shareText
//       viewController:(UIViewController *)viewController {
//    
//    
//    if (shareImage == nil) {
//        shareImage = [UIImage imageNamed:@"app_icon"];
//    }
//    
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    if (type!=UMSocialPlatformType_Sms) {
//        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:shareText thumImage:shareImage];
//        [shareObject setWebpageUrl:shareURL];
//        messageObject.shareObject = shareObject;
//    }else{
//        messageObject.text=StringFormat(shareText, shareURL);
//    }
//    
//    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:viewController completion:^(id data, NSError *error) {
//        NSString *message = nil;
//        if (!error) {
//            message = [NSString stringWithFormat:@"分享成功"];
//        } else {
//            message = @"分享取消";
//        }
//        [UIToast showMessage:message];
//    }];
//    
//    
//    
//}
//+ (BOOL)handleOpenURL:(NSURL *)url {
//  return  [[UMSocialManager defaultManager] handleOpenURL:url];
//}

@end
