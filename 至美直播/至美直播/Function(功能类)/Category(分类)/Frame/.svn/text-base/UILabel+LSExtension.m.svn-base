//
//  UILabel+LSExtension.m
//  driver
//
//  Created by 刘松 on 16/10/9.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "UILabel+LSExtension.h"

@implementation UILabel (LSExtension)
+(void)load
{
    
    //两个方法的Method
    
    if ([[UIDevice currentDevice].systemVersion doubleValue]<10.0) {
        return;
    }
        SEL originalSel= @selector(layoutSubviews);
        SEL newSel= @selector(ls_layoutSubviews);
        
        Method systemMethod = class_getInstanceMethod([self class], originalSel);
        Method swizzMethod = class_getInstanceMethod([self class], newSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd =
        class_addMethod([self class ], originalSel, method_getImplementation(swizzMethod),
                        method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod([self class], newSel, method_getImplementation(systemMethod),
                                method_getTypeEncoding(systemMethod));
        } else {
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }

    
}
-(void)ls_layoutSubviews
{
    
    [self ls_layoutSubviews];
    self.adjustsFontForContentSizeCategory=YES;
}

@end
