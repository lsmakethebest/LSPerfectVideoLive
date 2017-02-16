//
//  KCIdentiftyCardField.h
//  driver
// 身份证号
//  Created by 刘松 on 16/7/14.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CardBlock)(BOOL  enabled);
@interface KCIdentiftyCardField : UITextField
@property (nonatomic,copy) CardBlock cardBlock ;

@end
