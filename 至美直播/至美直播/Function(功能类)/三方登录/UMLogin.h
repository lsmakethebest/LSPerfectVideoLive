//
//  UMLogin.h
//  至美直播
//
//  Created by 刘松 on 16/10/17.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

typedef void (^UMLoginCompleteHandle)(BOOL suceess,NSString *uid,NSString *username,NSString *headicon,NSString *gender);

@interface UMLogin : NSObject

+(void)loginWithType:(UMSocialPlatformType)type viewController:(UIViewController*)vc completeHandle:(UMLoginCompleteHandle )completeHandle;


+(void)setUMAppKey;
+(BOOL)handleOpenURL:(NSURL*)url;


@end
