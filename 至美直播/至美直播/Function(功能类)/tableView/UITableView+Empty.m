
//
//  UITableView+Empty.m
//  自定义tableview
//
//  Created by 刘松 on 16/5/20.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "UITableView+Empty.h"
#import <objc/runtime.h>

#define TipLabelHeight 25
#define BadNetworkLabelHeight 25
#define TipImageViewHeight 130

@implementation UITableView (Empty)

#pragma mark - tipView
- (void)setTipView:(UIView *)tipView {
  objc_setAssociatedObject(self, @selector(tipView), tipView,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)tipView {
  return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - tipImageView
- (void)setTipImageView:(UIImageView *)tipImageView {
  objc_setAssociatedObject(self, @selector(tipImageView), tipImageView,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImageView *)tipImageView {
  return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - tipLabel
- (void)setTipLabel:(UILabel *)tipLabel {
  objc_setAssociatedObject(self, @selector(tipLabel), tipLabel,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)tipLabel {
  return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - startTip
- (void)setStartTip:(BOOL)startTip {
  if (startTip) {
    self.tipImage = [UIImage imageNamed:@"nomessage"];
    if (self.tipView == nil) {
      [self setupViews];
    }
  }
  objc_setAssociatedObject(self, @selector(startTip), @(startTip),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)startTip {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#pragma mark - retryButton
- (void)setRetryButton:(UIButton *)retryButton {
  objc_setAssociatedObject(self, @selector(retryButton), retryButton,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIButton *)retryButton {
  return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - 无网提示
- (void)setBadNetwork:(BOOL)badNetwork {
  if (self.startTip == NO)
    return;

  if (badNetwork) {
    self.tipView.hidden = NO;
    self.tipImageView.image = [UIImage imageNamed:@"bad_network"];
    if (self.retryButton == nil) {
      [self setupViews];
    }
    [self settingFrame];
    self.tipLabel.text = @"网络情况较差";
    self.badNetworkLabel.hidden = NO;
    self.retryButton.hidden = NO;
  } else {
    self.tipLabel.text = self.tipTitle;
    self.tipImageView.image = self.tipImage;
    if (self.retryButton) {
      self.badNetworkLabel.hidden = YES;
      self.retryButton.hidden = YES;
    }
  }
  objc_setAssociatedObject(self, @selector(badNetwork), @(badNetwork),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)badNetwork {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)ls_layoutSubviews {
  [self ls_layoutSubviews];
  if (self.startTip) {
    [self settingFrame];
  }
}

- (void)settingFrame {
  CGFloat realHeight = self.tipView.frame.size.height;
  CGSize size = self.bounds.size;
  if (self.badNetwork == NO) {
    self.tipImageView.frame =
        CGRectMake((size.width - TipImageViewHeight) / 2.0,
                   (realHeight - TipImageViewHeight - TipLabelHeight - 15) / 2,
                   TipImageViewHeight, TipImageViewHeight);
    self.tipLabel.frame =
        CGRectMake(0, CGRectGetMaxY(self.tipImageView.frame) + 15, size.width,
                   TipLabelHeight);
    self.badNetworkLabel.frame = CGRectZero;
    self.retryButton.frame = CGRectZero;
    return;
  }
  self.tipImageView.frame =
      CGRectMake((size.width - TipImageViewHeight) / 2.0,
                 (realHeight - TipImageViewHeight - 15 - TipLabelHeight - 15 -
                  BadNetworkLabelHeight - 15 - 35) /
                     2,
                 TipImageViewHeight, TipImageViewHeight);
  self.tipLabel.frame =
      CGRectMake(0, CGRectGetMaxY(self.tipImageView.frame) + 15, size.width,
                 TipLabelHeight);

  CGFloat screenWidth = self.frame.size.width;
  self.badNetworkLabel.frame =
      CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame) + 15, screenWidth,
                 BadNetworkLabelHeight);
  self.retryButton.frame =
      CGRectMake((screenWidth - 105) / 2,
                 CGRectGetMaxY(self.badNetworkLabel.frame) + 15, 105, 35);
}
- (void)setupViews {
  UIView *tipView = [[UIView alloc] init];
  tipView.backgroundColor = [UIColor colorWithWhite:0.913 alpha:1.000];
  //  tipView.backgroundColor = RandomColor;
  self.tipView = tipView;
  [self addSubview:tipView];

  UILabel *tipLabel = [[UILabel alloc] init];
  tipLabel.textColor = [UIColor lightGrayColor];
  tipLabel.textAlignment = NSTextAlignmentCenter;
  [tipView addSubview:tipLabel];
  self.tipLabel = tipLabel;
  //    self.tipLabel.backgroundColor=RandomColor;

  UIImageView *tipImageView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nomessage"]];
  tipImageView.contentMode = UIViewContentModeScaleAspectFit;
  [tipView addSubview:tipImageView];
  self.tipImageView = tipImageView;

  UILabel *badNetworkLabel = [[UILabel alloc] init];
  badNetworkLabel.textAlignment = NSTextAlignmentCenter;
  badNetworkLabel.text = @"请检查您的手机是否联网";
  badNetworkLabel.textColor = KCColor5;
  badNetworkLabel.font = KCFont4;
  [self.tipView addSubview:badNetworkLabel];
  self.badNetworkLabel = badNetworkLabel;
  //    badNetworkLabel.backgroundColor=RandomColor;

  UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
  [button setTitle:@"重新加载" forState:UIControlStateNormal];
  button.titleLabel.font = KCFont2;
  [button setTitleColor:KCColor6 forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"blueBack"]
                    forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"blueBackDisabled"]
                    forState:UIControlStateHighlighted];
  button.radius = 3;
  [self.tipView addSubview:button];
  self.retryButton = button;
  [self.retryButton addTarget:self
                       action:@selector(retryClick)
             forControlEvents:UIControlEventTouchUpInside];

  CGFloat realHeight =
      self.height - self.contentInset.top - self.contentInset.bottom;
//  DLog(@"top=========%lf---bottom---%lf", self.contentInset.top,
//       self.contentInset.bottom);
//  DLog(@"height=========%lf", realHeight);
  self.tipView.frame = CGRectMake(0, 0, self.frame.size.width, realHeight);
  [self settingFrame];
}

#pragma mark - tipImage
- (void)setTipImage:(UIImage *)tipImage {
  self.tipImageView.image = tipImage;
  objc_setAssociatedObject(self, @selector(tipImage), tipImage,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)tipImage {
  return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - tipTitle
- (void)setTipTitle:(NSString *)tipTitle {

  self.tipLabel.text = tipTitle;
  objc_setAssociatedObject(self, @selector(tipTitle), tipTitle,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)tipTitle {
  return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - tempTitle
- (void)setTempTitle:(NSString *)tempTitle {
  objc_setAssociatedObject(self, @selector(tempTitle), tempTitle,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)tempTitle {
  return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - badNetworkLabel
- (void)setBadNetworkLabel:(UILabel *)badNetworkLabel {

  objc_setAssociatedObject(self, @selector(badNetworkLabel), badNetworkLabel,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)badNetworkLabel {
  return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - retryBlock

- (void)setRetryBlock:(RetryBlock)retryBlock {
  objc_setAssociatedObject(self, @selector(retryBlock), retryBlock,
                           OBJC_ASSOCIATION_COPY);
}

- (RetryBlock)retryBlock {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)retryClick {
  self.tipView.hidden = YES;
  self.badNetwork = NO;
  if (self.retryBlock) {
    self.retryBlock();
  }
}
- (void)ls_reloaData {
  [self ls_reloaData];
  if (self.isFirstReloadData == NO) {
    self.isFirstReloadData = YES;
  } else {
    self.badNetwork = NO;
  }
  if (self.startTip) {
    if ([self.dataSource
            respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
      NSInteger section = [self.dataSource numberOfSectionsInTableView:self];
      self.tipView.hidden = !(section == 0);

      if (section == 1) {
        NSInteger rows =
            [self.dataSource tableView:self numberOfRowsInSection:0];
        self.tipView.hidden = !(rows == 0);
      }
    } else {
      NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:0];
      self.tipView.hidden = !(rows == 0);
    }
  } else {

    self.tipView.hidden = YES;
  }
}
void swizzleMethod(Class class, SEL originalSel, SEL newSel) {
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
+ (void)load {

  swizzleMethod([self class], @selector(reloadData), @selector(ls_reloaData));
  swizzleMethod([self class], @selector(willMoveToSuperview:),
                @selector(ls_willMoveToSuperview:));

  swizzleMethod([self class], @selector(layoutSubviews),
                @selector(ls_layoutSubviews));
}
- (void)ls_willMoveToSuperview:(UIView *)newSuperview {
  [self ls_willMoveToSuperview:newSuperview];
  if (newSuperview) {

    CGFloat realHeight =
        self.height - self.contentInset.top - self.contentInset.bottom;
//    DLog(@"top=========%lf---bottom---%lf", self.contentInset.top,
//         self.contentInset.bottom);
//    DLog(@"height=========%lf", realHeight);
    self.tipView.frame = CGRectMake(0, 0, self.frame.size.width, realHeight);
    [self settingFrame];
  }
}
- (void)setIsFirstReloadData:(BOOL)isFirstReloadData {
  objc_setAssociatedObject(self, @selector(isFirstReloadData),
                           @(isFirstReloadData),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isFirstReloadData {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end
