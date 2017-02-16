//
//  KCPayPasswordField.h
//  driver
//
//  Created by 刘松 on 16/7/5.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^CompleteHandle)(NSString *password);
@interface KCPayPasswordView : UIView
+(void)showWithprice:(NSString *)price type:(NSString*)type completeHandle:(CompleteHandle)completeHandle;

@end
