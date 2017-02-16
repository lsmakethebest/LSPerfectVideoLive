

//
//  KCIdentiftyCardField.m
//  driver
//
//  Created by 刘松 on 16/7/14.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCIdentiftyCardField.h"

@interface KCIdentiftyCardField ()

@property(nonatomic, copy) NSString *lastText;
@end
@implementation KCIdentiftyCardField

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
  self.lastText = @"";
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textChange)
             name:UITextFieldTextDidChangeNotification
           object:self];
}

- (BOOL)validateCard:(NSString *)textString {
    NSString *number = @"[0-9]{1,17}([0-9xX]){1}";
    if (textString.length<18) {
        number=@"[0-9]{0,17}";
    }
    NSPredicate *numberPre =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
    return [numberPre evaluateWithObject:textString];
}

- (void)textChange {
    if ([self validateCard:self.text]) {
        self.lastText=self.text;
    }else{
        self.text=self.lastText;
    }
    [self performCardBlock:self.lastText.length>=18];
}

-(void)performCardBlock:(BOOL)enabled
{
    if (self.cardBlock) {
        self.cardBlock(enabled);
    }
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
