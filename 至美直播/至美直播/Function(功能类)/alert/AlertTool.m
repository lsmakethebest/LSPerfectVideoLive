

//
//  AlertTool.m
//  driver
//
//  Created by 刘松 on 16/8/18.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "AlertTool.h"

#define AlertTooliOS8                                                          \
  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

typedef void (^Confirm)();
typedef void (^Cancle)();

@interface AlertTool ()
@property(nonatomic, copy) Confirm confirm;
@property(nonatomic, copy) Cancle cancle;
@end

@implementation AlertTool

+ (void)showWithViewController:(UIViewController *)viewController
                         title:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitle:(NSString *)otherButtonTitle
                       confirm:(void (^)())confirm
                        cancle:(void (^)())cancle

{

  if (AlertTooliOS8) {
    UIAlertController *alertController = [UIAlertController
        alertControllerWithTitle:title
                         message:message
                  preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    UIAlertAction *cancelAction =
        [UIAlertAction actionWithTitle:cancelButtonTitle
                                 style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action) {
                                   if (cancle) {
                                       cancle();
                                   }
                               }];
      // Add the actions.
      [alertController addAction:cancelAction];
      
      if (otherButtonTitle) {          
          UIAlertAction *otherAction =
          [UIAlertAction actionWithTitle:otherButtonTitle
                                   style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action) {
                                     if (confirm) {
                                         confirm();
                                     }
                                 }];
          [alertController addAction:otherAction];
      }
      
      
    [viewController presentViewController:alertController
                                 animated:YES
                               completion:nil];
  } else {
    AlertTool *tool = [[AlertTool alloc] init];
    tool.cancle = cancle;
    tool.confirm = confirm;
    [[UIApplication sharedApplication].keyWindow addSubview:tool];
    UIAlertView *TitleAlert =
        [[UIAlertView alloc] initWithTitle:title
                                   message:message
                                  delegate:tool
                         cancelButtonTitle:cancelButtonTitle
                         otherButtonTitles:otherButtonTitle, nil];
    [TitleAlert show];
  }
}
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    if (self.cancle) {
      self.cancle();
    }
  } else if (buttonIndex == 1) {
    if (self.confirm) {
      self.confirm();
    }
  }
  [self removeFromSuperview];
}

@end
