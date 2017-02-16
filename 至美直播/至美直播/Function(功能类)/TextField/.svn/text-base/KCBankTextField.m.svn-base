

//
//  KCBankTextField.m
//  driver
//
//  Created by 刘松 on 16/7/7.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCBankTextField.h"

@interface KCBankTextField ()

@property(nonatomic, copy) NSString *lastText;
@end
@implementation KCBankTextField

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setupViews];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setupViews];
  }
  return self;
}
- (void)setupViews {
  self.delegate = self;
  self.lastText = @"";
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textChange:)
             name:UITextFieldTextDidChangeNotification
           object:self];
  self.keyboardType = UIKeyboardTypePhonePad;
}
- (void)textChange:(NSNotification *)note {
  NSString *newString =
      [self.text stringByReplacingOccurrencesOfString:@"  " withString:@""];
  if (newString.length >= 19) {
    self.text = [self.text substringToIndex:27];
    self.lastText = [self.text substringToIndex:27];
    return;
  }
  if (self.lastText.length < self.text.length) { //增加

    NSString *pre = [self.text substringFromIndex:self.text.length - 1];
    if ([pre isEqualToString:@","] || [pre isEqualToString:@";"] ||
        [pre isEqualToString:@"*"] || [pre isEqualToString:@"#"]||[pre isEqualToString:@"+"]) {
      self.text = self.lastText;
    }
    NSString *text =
        [self.text stringByReplacingOccurrencesOfString:@"  " withString:@""];
    if (text.length % 4 == 0 && text.length > 0) {
      NSMutableString *str = [NSMutableString string];
      int number = text.length / 4;
      for (int i = 0; i < number; i++) {
        if (i == number) {
          [str appendString:[text substringWithRange:NSMakeRange(i * 4,
                                                                 text.length -
                                                                     i * 4)]];
        } else {
          [str appendString:[text substringWithRange:NSMakeRange(i * 4, 4)]];
          [str appendString:@"  "];
        }
      }
      self.text = str;
      self.lastText = str;
    }else{
        self.lastText=self.text;
    }
  } else { //删除
    NSString *str = self.text;
    if (self.text.length > 2 &&
        [[self.text substringFromIndex:self.text.length - 1]
            isEqualToString:@" "] &&
        ![[self.text substringFromIndex:self.text.length - 2]
            isEqualToString:@"  "]) {
      str = [self.text substringToIndex:self.text.length - 2];
    }
    self.text = str;
    self.lastText = str;
  }
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
  if (action == @selector(paste:))
    return NO;
  return [super canPerformAction:action withSender:sender];
}
@end
