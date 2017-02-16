
//
//  LSNumberTextField.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/7/28.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "LSNumberTextField.h"
#define LSKeyBoardHeight 220
// 图片路径
#define LSNumberTextFieldSrcName(file)                                         \
  [@"ls_number_textfield.bundle" stringByAppendingPathComponent:file]

//背景色
#define LSNumberTextFieldButtonBackgroundColor                                 \
  [UIColor colorWithWhite:1.000 alpha:0.98]

//背景色
#define LSNumberTextFieldHeightImage                                           \
  [UIImage imageNamed:LSNumberTextFieldSrcName(@"Keyboard_Num_Normal")]

#define LSNumberTextFieldFont [UIFont systemFontOfSize:22]
@interface LSNumberTextField ()
@property(nonatomic, strong) UIView *keyboardView;

@property(nonatomic, strong) NSMutableArray *numberButtons;
@property(nonatomic, weak) UIButton *okButton;
@end

@implementation LSNumberTextField

- (NSMutableArray *)numberButtons {
  if (!_numberButtons) {

    _numberButtons = [NSMutableArray array];
  }
  return _numberButtons;
}
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

  self.inputView = self.keyboardView;
    self.inputAccessoryView=[[UIView alloc]init];
}
- (UIView *)keyboardView {
  if (!_keyboardView) {
    _keyboardView = [[UIView alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _keyboardView.frame = CGRectMake(0, 0, width, LSKeyBoardHeight);
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image =
        [UIImage imageNamed:LSNumberTextFieldSrcName(@"Keyboard_BG")];
    [_keyboardView addSubview:imageView];

    CGFloat lineWidth = 1 / [UIScreen mainScreen].scale;
    CGFloat buttonWidth = (width - lineWidth * 4) / 4;
    CGFloat buttonHeight = (LSKeyBoardHeight - lineWidth * 3) / 4;
    for (int i = 0; i <= 9; i++) {
      UIButton *button = [[UIButton alloc] init];
      [_keyboardView addSubview:button];
      [button setTitle:[NSString stringWithFormat:@"%d", i]
              forState:UIControlStateNormal];
      button.tag = i;
      button.backgroundColor = LSNumberTextFieldButtonBackgroundColor;

      [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [button setBackgroundImage:LSNumberTextFieldHeightImage
                        forState:UIControlStateHighlighted];
      button.imageView.contentMode = UIViewContentModeScaleAspectFill;

      [button addTarget:self
                    action:@selector(numberClick:)
          forControlEvents:UIControlEventTouchUpInside];
      button.titleLabel.font = LSNumberTextFieldFont;
      [self.numberButtons addObject:button];
      if (i == 0) {
        button.frame = CGRectMake(lineWidth + buttonWidth,
                                  buttonHeight * 3 + 4 * lineWidth, buttonWidth,
                                  buttonHeight);
      } else {
        button.frame =
            CGRectMake((buttonWidth + lineWidth) * ((i - 1) % 3),
                       lineWidth + (buttonHeight + lineWidth) * ((i - 1) / 3),
                       buttonWidth, buttonHeight);
      }
    }

    UIButton *point = [[UIButton alloc] init];
    [point addTarget:self
                  action:@selector(numberClick:)
        forControlEvents:UIControlEventTouchUpInside];
    point.tag = 10;
    [point setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [point setTitle:@"." forState:UIControlStateNormal];
    point.titleLabel.font = [UIFont systemFontOfSize:25];
    point.frame = CGRectMake(0, 3 * buttonHeight + 4 * lineWidth, buttonWidth,
                             buttonHeight);
    [point setBackgroundImage:LSNumberTextFieldHeightImage
                     forState:UIControlStateHighlighted];
    [_keyboardView addSubview:point];

    //隐藏键盘按钮
    UIButton *hide = [[UIButton alloc] init];
    [hide addTarget:self
                  action:@selector(hideKeyboard)
        forControlEvents:UIControlEventTouchUpInside];
    [hide
        setImage:[UIImage imageNamed:LSNumberTextFieldSrcName(@"Keyboard_Hide")]
        forState:UIControlStateNormal];

    hide.frame =
        CGRectMake(CGRectGetMaxX([self.numberButtons[0] frame]) + lineWidth,
                   CGRectGetMaxY([self.numberButtons[9] frame]) + lineWidth,
                   buttonWidth, buttonHeight);
    [hide setBackgroundImage:LSNumberTextFieldHeightImage
                    forState:UIControlStateHighlighted];
    [_keyboardView addSubview:hide];

    CGFloat buttonHeight2 = (LSKeyBoardHeight - lineWidth) / 2;

    //删除按钮
    UIButton *delete = [[UIButton alloc] init];
    [delete addTarget:self
                  action:@selector(deleteString)
        forControlEvents:UIControlEventTouchUpInside];
    [delete setImage:[UIImage imageNamed:LSNumberTextFieldSrcName(
                                             @"Keyboard_Backspace")]
            forState:UIControlStateNormal];
    [delete setBackgroundImage:LSNumberTextFieldHeightImage
                      forState:UIControlStateHighlighted];
    delete.frame =
        CGRectMake(CGRectGetMaxX([self.numberButtons[3] frame]) + lineWidth,
                   lineWidth, buttonWidth, buttonHeight2);
    ;
    [_keyboardView addSubview:delete];

    //确定按钮
    UIButton *ok = [[UIButton alloc] init];
    ok.enabled = NO;
    [ok setBackgroundImage:[UIImage imageNamed:LSNumberTextFieldSrcName(
                                                   @"keyboard_click")]
                  forState:UIControlStateNormal];
      [ok setBackgroundImage:[UIImage imageNamed:LSNumberTextFieldSrcName(
                                                                          @"keyboard_click")]
                    forState:UIControlStateDisabled];
    [ok setBackgroundImage:[UIImage
                               imageNamed:LSNumberTextFieldSrcName(
                                              @"keyboard_click_highlighted")]
                  forState:UIControlStateHighlighted];

    ok.imageView.contentMode = UIViewContentModeScaleAspectFill;
    ok.frame =
        CGRectMake(CGRectGetMaxX([self.numberButtons[6] frame]) - 0.2,
                   CGRectGetMaxY([self.numberButtons[6] frame]) - 0.2,
                   width - (CGRectGetMaxX([self.numberButtons[6] frame]) - 0.2),
                   buttonHeight2);
    [ok addTarget:self
                  action:@selector(hideKeyboard)
        forControlEvents:UIControlEventTouchUpInside];
    [ok setTitle:@"确定" forState:UIControlStateNormal];
    [ok setTitleColor:[UIColor colorWithWhite:1.000 alpha:0.663]
             forState:UIControlStateDisabled];

    [_keyboardView addSubview:ok];
    self.okButton = ok;
    ok.backgroundColor = LSNumberTextFieldButtonBackgroundColor;
    hide.backgroundColor = LSNumberTextFieldButtonBackgroundColor;
    delete.backgroundColor = LSNumberTextFieldButtonBackgroundColor;
    point.backgroundColor = LSNumberTextFieldButtonBackgroundColor;
  }
  return _keyboardView;
}
//删除
- (void)deleteString {
  [self deleteBackward];
  BOOL v = ![self.text isEqualToString:@""];
  self.okButton.enabled = v;
}
//隐藏
- (void)hideKeyboard {

  [self resignFirstResponder];
}

//输入文字
- (void)numberClick:(UIButton *)button {

  NSString *lastString = self.text;
  switch (button.tag) {
  case 0:
    [self insertText:@"0"];

    break;
  case 1:
    [self insertText:@"1"];

    break;
  case 2:
    [self insertText:@"2"];

    break;
  case 3:
    [self insertText:@"3"];

    break;
  case 4:
    [self insertText:@"4"];

    break;
  case 5:
    [self insertText:@"5"];

    break;
  case 6:
    [self insertText:@"6"];

    break;
  case 7:
    [self insertText:@"7"];

    break;
  case 8:
    [self insertText:@"8"];

    break;
  case 9:
    [self insertText:@"9"];

    break;
  case 10:
    [self insertText:@"."];

    break;
  default:
    break;
  }
  if (![self validateNumber:self.text]) {
    self.text = lastString;
  }
  BOOL v = ![self.text isEqualToString:@""];
  self.okButton.enabled = v;
}
- (BOOL)validateNumber:(NSString *)textString {
    
//  NSString *number = @"^(0|[1-9][0-9]{0,9})([.][0-9]{0,2})?$";
    NSString *number = @"^([1-9][0-9]{0,9})([.][0-9]{0,2})?$";
  NSPredicate *numberPre =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
  return [numberPre evaluateWithObject:textString];
}
@end
