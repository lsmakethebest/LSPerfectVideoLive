//
//  UIAlertView+CustomAlertView.h
//  driver
//
//  Created by 刘松 on 16/8/2.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CustomAlertViewBlock)(NSInteger buttonIndex);

@interface UIAlertView (CustomAlertView)<UIAlertViewDelegate>

@property (nonatomic,copy) CustomAlertViewBlock block;

+ (instancetype)showWithTitle:(nullable NSString *)title message:(nullable NSString *)message  cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles: (NSString *)otherButtonTitle  block:(CustomAlertViewBlock)block;


@end
