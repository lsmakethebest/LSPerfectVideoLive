

//
//  UIButton+LSExtension.m
//  LSCountDown
//
//  Created by ls on 16/1/18.
//  Copyright © 2016年 song. All rights reserved.
//

#import "UIButton+LSExtension.h"
#import <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, assign) CGFloat ls_acceptedEventTime;

@end

@implementation UIButton (LSExtension)
- (void)ls_startCountWithTime:(NSInteger)time
                  subTitle:(NSString *)subTitle
             disabledColor:(UIColor *)disabledColor {
    __block NSInteger timeOut = time + 1;
    dispatch_source_t timer = dispatch_source_create(
                                                     DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
                                                     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0),
                              1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        timeOut--;
        if (timeOut == 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                self.ls_countDowning=NO;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitleColor:disabledColor forState:UIControlStateDisabled];
                [self setTitle:[NSString stringWithFormat:@"%ld%@", timeOut,subTitle]
                      forState:UIControlStateDisabled];
                self.enabled = NO;
                self.ls_countDowning=YES;
            });
        }
    });
    dispatch_resume(timer);
}



- (void)setLs_countDowning:(BOOL)ls_countDowning
{
    
    objc_setAssociatedObject(self, @selector(ls_countDowning),
                             @(ls_countDowning), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)ls_countDowning
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}



- (void)setLs_acceptEventInterval:(CGFloat)ls_acceptEventInterval {
    objc_setAssociatedObject(self, @selector(ls_acceptEventInterval),
                             @(ls_acceptEventInterval), OBJC_ASSOCIATION_RETAIN);
}
- (CGFloat)ls_acceptEventInterval {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setLs_acceptedEventTime:(CGFloat)ls_acceptedEventTime {
    objc_setAssociatedObject(self, @selector(ls_acceptedEventTime),
                             @(ls_acceptedEventTime), OBJC_ASSOCIATION_RETAIN);
}
- (CGFloat)ls_acceptedEventTime {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
- (void)setLs_autoHideKeyboard:(BOOL)ls_autoHideKeyboard {
    objc_setAssociatedObject(self, @selector(ls_autoHideKeyboard),
                             @(ls_autoHideKeyboard), OBJC_ASSOCIATION_RETAIN);
}
- (BOOL)ls_autoHideKeyboard {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}



+ (void)load {
    
    SEL selA = @selector(sendAction:to:forEvent:);
    SEL selB = @selector(ls_sendAction:to:forEvent:);
    Method methodA = class_getInstanceMethod(self, selA);
    Method methodB = class_getInstanceMethod(self, selB);
    //将 methodB的实现 添加到系统方法中 也就是说
    //将methodA方法指针添加成方法methodB的  返回值表示是否添加成功
    BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB),
                                 method_getTypeEncoding(methodB));
    //添加成功了 说明 本类中不存在methodB
    //所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
    if (isAdd) {
        class_replaceMethod(self, selB, method_getImplementation(methodA),
                            method_getTypeEncoding(methodA));
    } else {
        //添加失败了 说明本类中 有methodB的实现，此时只需要将
        // methodA和methodB的IMP互换一下即可。
        method_exchangeImplementations(methodA, methodB);
    }
    
    isAdd = NO;
    
    SEL selC = @selector(willMoveToSuperview:);
    SEL selD = @selector(ls_willMoveToSuperview:);
    Method methodC = class_getInstanceMethod(self, selC);
    Method methodD = class_getInstanceMethod(self, selD);
    //将 methodB的实现 添加到系统方法中 也就是说
    //将methodA方法指针添加成方法methodB的  返回值表示是否添加成功
    isAdd = class_addMethod(self, selC, method_getImplementation(methodD),
                            method_getTypeEncoding(methodD));
    //添加成功了 说明 本类中不存在methodB
    //所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
    if (isAdd) {
        class_replaceMethod(self, selD, method_getImplementation(methodC),
                            method_getTypeEncoding(methodC));
    } else {
        //添加失败了 说明本类中 有methodB的实现，此时只需要将
        // methodA和methodB的IMP互换一下即可。
        method_exchangeImplementations(methodC, methodD);
    }
}

- (void)ls_willMoveToSuperview:(UIView *)newSuperview {
    [self ls_willMoveToSuperview:newSuperview];
    self.ls_autoHideKeyboard = NO;
}
- (void)ls_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (NSDate.date.timeIntervalSince1970 - self.ls_acceptedEventTime <
        self.ls_acceptEventInterval)
        return;
    if (self.ls_acceptEventInterval > 0) {
        self.ls_acceptedEventTime = NSDate.date.timeIntervalSince1970;
    }
    if (self.ls_autoHideKeyboard) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }
    [self ls_sendAction:action to:target forEvent:event];
}




@end
