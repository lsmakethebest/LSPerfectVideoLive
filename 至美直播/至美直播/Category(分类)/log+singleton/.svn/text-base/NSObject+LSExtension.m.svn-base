

//
//  NSObject+LSExtension.m
//  driver
//
//  Created by 刘松 on 16/9/1.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "NSObject+LSExtension.h"

#import <UIKit/UIKit.h>

@implementation NSObject (LSExtension)
+ (void)ls_exchangeClassMethod:(Class) class
                   originalSel:(SEL)originalSelector
                        newSel:(SEL)newSelector {

  Method originalMethod = class_getClassMethod(class, originalSelector);
  Method newMethod = class_getClassMethod(class, newSelector);
  //将 newMethod的实现 添加到系统方法中 也就是说 将 originalMethod方法指针添加成
  //方法newMethod的  返回值表示是否添加成功
  BOOL isAdd = class_addMethod(self, originalSelector,
                               method_getImplementation(newMethod),
                               method_getTypeEncoding(newMethod));
  //添加成功了 说明 本类中不存在methodB
  //所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
  if (isAdd) {
    class_replaceMethod(self, newSelector,
                        method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
  } else {
    //添加失败了 说明本类中 有methodB的实现，此时只需要将
    // originalMethod和newMethod的IMP互换一下即可。
    method_exchangeImplementations(originalMethod, newMethod);
  }
}
+ (void)ls_exchangeInstanceMethod : (Class) class originalSel
                                      : (SEL)originalSelector newSel
                                        : (SEL)newSelector {
  Method originalMethod = class_getInstanceMethod(class, originalSelector);
  Method newMethod = class_getInstanceMethod(class, newSelector);
  //将 newMethod的实现 添加到系统方法中 也就是说 将 originalMethod方法指针添加成
  //方法newMethod的  返回值表示是否添加成功
  BOOL isAdd = class_addMethod(class, originalSelector,
                               method_getImplementation(newMethod),
                               method_getTypeEncoding(newMethod));
  //添加成功了 说明 本类中不存在methodB
  //所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
  if (isAdd) {
    class_replaceMethod(class, newSelector,
                        method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
  } else {
    //添加失败了 说明本类中 有methodB的实现，此时只需要将
    // originalMethod和newMethod的IMP互换一下即可。
    method_exchangeImplementations(originalMethod, newMethod);
  }

}

@end
