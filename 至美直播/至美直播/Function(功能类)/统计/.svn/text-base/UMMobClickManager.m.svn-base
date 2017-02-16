

//
//  UMMobClickManager.m
//  driver
//
//  Created by 刘松 on 16/7/27.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "UMMobClickManager.h"
#import <UMMobClick/MobClick.h>

@implementation UMMobClickManager
+ (void)startMobClick {
    
    UMConfigInstance.appKey = UMKey;
    // UMConfigInstance.ChannelId = @"Web";
    NSString *version = [[[NSBundle mainBundle] infoDictionary]
                         objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];
    //    [MobClick setLogEnabled:YES];
    UMConfigInstance.ePolicy = BATCH;
    //    [MobClick setLogSendInterval:90];
    
    [MobClick startWithConfigure:
     UMConfigInstance]; //配置以上参数后调用此方法初始化SDK！
}
+ (void)event:(NSString *)eventId
{
    [MobClick event:eventId];
}
@end
