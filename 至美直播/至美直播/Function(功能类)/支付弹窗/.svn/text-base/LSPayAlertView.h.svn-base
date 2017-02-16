//
//  LSPayAlertView.h
//  LSPayAlertView
//
//  Created by 刘松 on 16/5/3.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteHandle)(NSString *password);

@interface LSPayAlertView : UIView

@property (nonatomic,copy)CompleteHandle completeHandle;

+(void)showWithTitle:(NSString *)title price:(NSString*)price completeHandle:(CompleteHandle)completeHandle;

@end
