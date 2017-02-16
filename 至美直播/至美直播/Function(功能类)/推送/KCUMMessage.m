

//
//  KCUMMessage.m
//  driver
//
//  Created by 刘松 on 16/7/25.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCUMMessage.h"


@interface KCUMMessage ()

@end

static KCUMMessage *instance = nil;

@implementation KCUMMessage

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

#pragma mark - 初始化友盟推送
- (void)initUmengPush:(NSDictionary *)launchOptions appDelegate:(AppDelegate *)appDelegate {
    
    //用于在友盟注册设备
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if (cls && [cls respondsToSelector:deviceIDSelector]) {
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:@{
                                              @"oid" : deviceID
                                              }options:NSJSONWritingPrettyPrinted
                                      error:nil];
    NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    
    
    
    
    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
    [UMessage startWithAppkey:UMKey launchOptions:launchOptions];
    
    
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=appDelegate;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
//打开日志，方便调试
#ifdef DEBUG
    [UMessage setLogEnabled:YES];
#endif
    
    /**  如果你期望使用交互式(只有iOS
     8.0及以上有)的通知，请参考下面注释部分的初始化代码
     //register remoteNotification types （iOS 8.0及其以上版本）
     UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction
     alloc] init];
     action1.identifier = @"action1_identifier";
     action1.title=@"Accept";
     action1.activationMode =
     UIUserNotificationActivationModeForeground;//当点击的时候启动程序
     
     UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction
     alloc] init];  //第二按钮
     action2.identifier = @"action2_identifier";
     action2.title=@"Reject";
     action2.activationMode =
     UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
     action2.authenticationRequired =
     YES;//需要解锁才能处理，如果action.activationMode =
     UIUserNotificationActivationModeForeground;则这个属性被忽略；
     action2.destructive = YES;
     
     UIMutableUserNotificationCategory *actionCategory =
     [[UIMutableUserNotificationCategory alloc] init];
     actionCategory.identifier = @"category1";//这组动作的唯一标示
     [actionCategory setActions:@[action1,action2]
     forContext:(UIUserNotificationActionContextDefault)];
     
     NSSet *categories = [NSSet setWithObject:actionCategory];
     
     //如果默认使用角标，文字和声音全部打开，请用下面的方法
     [UMessage registerForRemoteNotifications:categories];
     
     //如果对角标，文字和声音的取舍，请用下面的方法
     //UIRemoteNotificationType types7 =
     UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
     //UIUserNotificationType types8 =
     UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
     //[UMessage registerForRemoteNotifications:categories withTypesForIos7:types7
     withTypesForIos8:types8];
     */
    [UMessage setAutoAlert:NO];
    // for log
    // 调试信息
#ifdef DEBUG
    [UMessage setLogEnabled:YES];
#endif
}

- (void)registerDeviceTokenWithdeviceToken:(NSData *)deviceToken {
    
    NSString *pushToken =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
//    KCUserDefaultSetToken(pushToken);
#ifdef DEBUG
    [self logDebugDeviceToken:deviceToken];
#endif
}
- (void)receiveNotificationWithUserInfo:(NSDictionary *)userInfo {
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    NSString *type=userInfo.mj_JSONString;
    
    
    if (userInfo[@"data"]==nil||[userInfo[@"data"] isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *type=userInfo[@"data"][@"type"];
    if (type.length<=0) {
        return;
    }
    if ([UIApplication sharedApplication].applicationState ==
        UIApplicationStateActive) {
        //前台
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:userInfo[@"aps"][@"alert"]
                                   message:type
                                  delegate:self
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:userInfo[@"aps"][@"alert"]
                                   message:type
         
                                  delegate:self
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
    }
}

- (void)receiveNotificationWithLanunchOptions:(NSDictionary *)launchOptions {
    if (launchOptions &&
        launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        [self receiveNotificationWithUserInfo:
         launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
    }
}

- (void)logDebugDeviceToken:(NSData *)deviceToken {
    NSString *pushToken =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    DLog(@"\n\n\n\n\n---------------测试设备deviceToken:----------------%@\n\n\n\n\n\n", pushToken);
}
- (void)unregisterRemoteNotification {
    [UMessage unregisterForRemoteNotifications];
}

@end
