//
//  NSObject+LSExtension.h
//  driver
//
//  Created by 刘松 on 16/9/1.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LSExtension)
//交换类方法
+ (void)ls_exchangeClassMethod:(Class) class
                   originalSel:(SEL)originalSelector
                        newSel:(SEL)newSelector;
//交换对象方法
+ (void)ls_exchangeInstanceMethod:(Class) class
                      originalSel:(SEL)originalSelector
                           newSel:(SEL)newSelector;

@end
