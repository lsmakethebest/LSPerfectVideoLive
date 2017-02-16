//
//  InitialSetting.m
//  至美直播
//
//  Created by 刘松 on 16/11/1.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "InitialSetting.h"

#import "UMLogin.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>

#import <RongIMLib/RongIMLib.h>
#import <PLMediaStreamingKit/PLStreamingEnv.h>


@implementation InitialSetting

+(void)setting
{
    
    [UMLogin setUMAppKey];
    //
    [SMSSDK registerApp:MOBAppKey
             withSecret:MOBAppSecrect];
    [SMSSDK enableAppContactFriends:NO];
    
    
    
    [PLStreamingEnv initEnv];
//    [PLStreamingEnv setLogLevel:PLStreamLogLevelDebug];
//    [PLStreamingEnv enableFileLogging];
//    
    [[RCIMClient sharedRCIMClient]initWithAppKey:RYKey];
    
    
    
    
}
@end
