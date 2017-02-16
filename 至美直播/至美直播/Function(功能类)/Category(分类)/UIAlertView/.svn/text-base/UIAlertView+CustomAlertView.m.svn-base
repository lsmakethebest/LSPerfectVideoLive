

//
//  UIAlertView+CustomAlertView.m
//  driver
//
//  Created by 刘松 on 16/8/2.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "UIAlertView+CustomAlertView.h"
#import <objc/runtime.h>

@implementation UIAlertView (CustomAlertView)

+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitle
                        block:(CustomAlertViewBlock)block {

  UIAlertView *alert =
      [[UIAlertView alloc] initWithTitle:title
                                 message:message
                                delegate:nil
                       cancelButtonTitle:cancelButtonTitle
                       otherButtonTitles:otherButtonTitle, nil];
    alert.delegate=alert;
  alert.block = block;
  [alert show];
  return alert;
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
    
  if (self.block) {
    self.block(buttonIndex);
  }
}
- (void)setBlock:(CustomAlertViewBlock)block {
  objc_setAssociatedObject(self, @selector(block), block,
                           OBJC_ASSOCIATION_COPY);
}
- (CustomAlertViewBlock)block {
  return objc_getAssociatedObject(self, _cmd);
}
+ (void)load {
//  swizzleMethod1([self class], @selector(show), @selector(ls_show));
}

- (void)ls_show {
  [self ls_show];
  UIAlertController *vc = [self valueForKey:@"_alertController"];
  UILabel *label;
  if (vc) { // ios8+
      DLog(@"class========%@",[vc.view.subviews[0]
           .subviews[1]
           .subviews[0]
           .subviews[2] class]);
      vc.view.subviews[0]
      .subviews[1]
      .subviews[0]
      .subviews[2].tintColor=RandomColor;
    for (UIView *view in vc.view.subviews[0]
             .subviews[1]
             .subviews[0]
             .subviews[0]
             .subviews[0]
             .subviews) {
      if ([view isKindOfClass:[UILabel class]]) {
        label = (UILabel *)view;
        if ([label.text isEqualToString:self.title]) {
          label.textColor = RandomColor;
        }
      }
    }

  } else { // ios7
    for (UIView *view in self.subviews) {
      if ([view isKindOfClass:[UILabel class]]) {
        label = (UILabel *)view;
        if ([label.text isEqualToString:self.message]) {
          label.textColor = RandomColor;
        }
      }
    }
  }

  //    DLog(@"class========%@",vc.view.subviews);
  //    label.textColor=RandomColor;
}
void swizzleMethod1(Class class, SEL originalSel, SEL newSel) {
  //两个方法的Method
  Method systemMethod = class_getInstanceMethod(class, originalSel);
  Method swizzMethod = class_getInstanceMethod(class, newSel);

  //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
  BOOL isAdd =
      class_addMethod(class, originalSel, method_getImplementation(swizzMethod),
                      method_getTypeEncoding(swizzMethod));
  if (isAdd) {
    //如果成功，说明类中不存在这个方法的实现
    //将被交换方法的实现替换到这个并不存在的实现
    class_replaceMethod(class, newSel, method_getImplementation(systemMethod),
                        method_getTypeEncoding(systemMethod));
  } else {
    //否则，交换两个方法的实现
    method_exchangeImplementations(systemMethod, swizzMethod);
  }
}
@end
