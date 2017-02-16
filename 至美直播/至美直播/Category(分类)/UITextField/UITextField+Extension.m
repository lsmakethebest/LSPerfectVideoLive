

//
//  UITextField+Extension.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/1.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>
@implementation UITextField (Extension)
-(BOOL)isNullAndShowMessage
{
    if ([self.text isEqualToString:@""]) {
        [MBProgressHUD showError:self.placeholder];
        return  YES;
    }
    if ([self.placeholder rangeOfString:@"手机号"].length>0||[self.placeholder rangeOfString:@"电话"].length>0) {

        if (self.text.length!=11) {

             [MBProgressHUD showError:@"请输入正确的手机号"];
            return YES;
        }
//        if (self.text.length<11) {
//            [MBProgressHUD showError:@"手机号长度小于11位"];
//            return YES;
//        }
//        if (self.text.length>11) {
//            [MBProgressHUD showError:@"手机号长度超过11位"];
//            return YES;
//        }
    }
    return NO;
}
-(BOOL)isNull
{
    return  [self.text isEqualToString:@""]||self.text==nil;

}

-(void)setup
{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:self];
}
-(void)setMaxLength:(int)maxLength
{
    
    objc_setAssociatedObject(self, @selector(maxLength), @(maxLength),OBJC_ASSOCIATION_ASSIGN);
    [self setup];
}
-(int)maxLength
{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}
-(void)textDidChange
{
    if (self.maxLength==0) {
        return;
    }
    if (self.text.length>self.maxLength) {
        self.text=[self.text substringToIndex:self.maxLength];
    }
}
@end
