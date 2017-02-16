//
//  KCUMMessage.h
//  driver
//
//  Created by 刘松 on 16/7/25.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMessage.h"
#import "AppDelegate.h"

@interface KCUMMessage : NSObject


#pragma mark - 初始化友盟推送
- (void)initUmengPush:(NSDictionary *)launchOptions appDelegate:(AppDelegate*)appDelegate;

+ (instancetype)sharedInstance;
- (void)unregisterRemoteNotification;

-(void)receiveNotificationWithUserInfo:(NSDictionary*)userInfo;

-(void)receiveNotificationWithLanunchOptions:(NSDictionary*)launchOptions;
-(void)logDebugDeviceToken:(NSData *)deviceToken;
- (void)registerDeviceTokenWithdeviceToken:(NSData *)deviceToken;
@end
