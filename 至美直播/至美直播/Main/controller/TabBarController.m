

//
//  TabBarController.m
//  至美直播
//
//  Created by 刘松 on 16/8/5.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSHomeViewController.h"

#import "NavigationController.h"
#import "ShowTimeViewController.h"
#import "TabBarController.h"
#import <AVFoundation/AVFoundation.h>
#import "LSMineTableController.h"
#import "PLShowViewController.h"

#import "LSRecordingViewController.h"

@interface TabBarController () <UITabBarControllerDelegate>



@end

@implementation TabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
    DLog(@"-------------%@",NSLocalizedString(@"name", nil));

  NavigationController *home = [[NavigationController alloc]
      initWithRootViewController:[[LSHomeViewController alloc] init]];

  [home.tabBarItem
      setImage:[[UIImage imageNamed:@"toolbar_home_26x26_"]
                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  [home.tabBarItem
      setSelectedImage:
          [[UIImage imageNamed:@"toolbar_home_sel_44x44_"]
              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];


    
    
    
    
  NavigationController *live = [[NavigationController alloc] init];
  [live.tabBarItem
      setImage:[[UIImage imageNamed:@"toolbar_live_42x42_"]
                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  [live.tabBarItem
      setSelectedImage:
          [[UIImage imageNamed:@"toolbar_live_42x42_"]
              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

  NavigationController *mine = [[NavigationController alloc]
      initWithRootViewController:[[LSMineTableController alloc] initWithStyle:(UITableViewStyleGrouped)]];
  [mine.tabBarItem
      setImage:[[UIImage imageNamed:@"toolbar_me_44x44_"]
                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  [mine.tabBarItem
      setSelectedImage:
          [[UIImage imageNamed:@"toolbar_me_sel_44x44_"]
              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    CGFloat margin=8;
  [home.tabBarItem setImageInsets:UIEdgeInsetsMake(margin, 0, -margin, 0)];
  [live.tabBarItem setImageInsets:UIEdgeInsetsMake(margin, 0, -margin, 0)];
  [mine.tabBarItem setImageInsets:UIEdgeInsetsMake(margin, 0, -margin, 0)];

  self.viewControllers = @[ home, live, mine ];

  self.delegate = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController
    shouldSelectViewController:(UIViewController *)viewController {
    
    
    
  if ([tabBarController.childViewControllers indexOfObject:viewController] ==
      tabBarController.childViewControllers.count - 2) {
//    // 判断是否是模拟器
//    if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
//      [UIToast showMessage:@"请用真机进行测试, "
//                           @"此模块不支持模拟器测试"];
//      return NO;
//    }
//
//    // 判断是否有摄像头
//    if (![UIImagePickerController
//            isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//      [UIToast showMessage:@"您的设备没有摄像头或者相关的驱动, "
//                           @"不能进行直播"];
//      return NO;
//    }
//
//    // 判断是否有摄像头权限
//    AVAuthorizationStatus authorizationStatus =
//        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if (authorizationStatus == AVAuthorizationStatusRestricted ||
//        authorizationStatus == AVAuthorizationStatusDenied) {
//      [UIToast showMessage:
//                   @"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
//      return NO;
//    }
//
//    // 开启麦克风权限
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
//      [audioSession
//          performSelector:@selector(requestRecordPermission:)
//               withObject:^(BOOL granted) {
//                 if (granted) {
//                   return YES;
//                 } else {
//                   [UIToast showMessage:@"app需要访问您的麦克风。\n请启用麦克风"
//                                        @"-设置/隐私/麦克风"];
//                   return NO;
//                 }
//               }];
//    }


//         UINavigationController *showTimeVc =
//        [UIStoryboard
//            storyboardWithName:@"chat"
//                        bundle:nil]
//            .instantiateInitialViewController;
      
//      [self presentViewController:[[UIStoryboard storyboardWithName:@"ShowTimeViewController"
//                                                             bundle:nil] instantiateInitialViewController ] animated:YES completion:nil];
      [self presentViewController:[[LSRecordingViewController alloc]init] animated:YES completion:nil];
      

//      UINavigationController *nav=  self.selectedViewController;
//      [nav pushViewController:showTimeVc.topViewController animated:YES];


    return NO;
  }
  return YES;
}

@end
