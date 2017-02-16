//
//  AppDelegate.m
//  至美直播
//
//  Created by 刘松 on 16/8/5.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"

#import "InitialSetting.h"

#import "UMLogin.h"

@interface AppDelegate ()



@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if ([LSUserTool sharedUserTool].userModel!=nil) {
        
        self.window.rootViewController = [[TabBarController alloc] init];
    }else{
        UIViewController *vc=[[UIStoryboard storyboardWithName:@"login" bundle:nil]instantiateInitialViewController];
        self.window.rootViewController = vc;
        
    }
    
    [self.window makeKeyAndVisible];
    
    [InitialSetting setting];
    
  return YES;
    
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return [UMLogin handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return [UMLogin handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    [LSNotificationCenter postNotificationName:LSWillResignActiveNotification object:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
     [LSNotificationCenter postNotificationName:LSBecomeActiveNotification object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}






@end
