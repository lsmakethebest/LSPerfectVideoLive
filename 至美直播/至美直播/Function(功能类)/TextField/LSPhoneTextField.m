//
//  LSPhoneTextField.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/31.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "LSPhoneTextField.h"

@interface LSPhoneTextField ()<UITextFieldDelegate>

@property (nonatomic,copy) NSString *lastText;
@property (nonatomic,assign) int length;

@end

@implementation LSPhoneTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self setupEvents];
    }
    return self;
}
-(void)setupEvents
{
    self.lastText=@"";
    self.length=11;
    self.keyboardType=UIKeyboardTypePhonePad;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self];
    
}

-(void)changeText
{
    
    if (self.text.length>self.lastText.length) {
         NSString *footer = [self.text substringFromIndex:self.lastText.length];
        if ([self validateCard:footer]) {
            self.lastText=self.text;
        }else{
            self.text=self.lastText;
        }
    }else{
        self.lastText=self.text;
    }
    if (self.text.length>=self.length) {
        self.lastText=self.text=[self.text substringToIndex:self.length];
        
    }
    
    if (self.block) {
        self.block(self.lastText.length>=self.length);
    }
    
}
- (BOOL)validateCard:(NSString *)textString {
    NSString *number = @"^[0-9]{1,18}";
    NSPredicate *numberPre =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
    return [numberPre evaluateWithObject:textString];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}









@end
