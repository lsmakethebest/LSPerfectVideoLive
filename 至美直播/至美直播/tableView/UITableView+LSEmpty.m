
//
//  UITableView+Empty.m
//  自定义tableview
//
//  Created by 刘松 on 16/5/20.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "UITableView+LSEmpty.h"
#import <objc/runtime.h>

#define TipLabelHeight 25
#define BadNetworkLabelHeight 25

#define LSLoadingLabelHeight 25

#define RetryButtonHeight 35
#define RetryButtonWidth 105

#define TipImageViewWidth 100
#define TipImageViewHeight 100

#define LSBadNetworkTitle1 @"网络情况较差"
#define LSBadNetworkTitle2 @"请检查您的手机是否联网"

//分别对应三个margin
#define LSMargin1 0
#define LSMargin2 0
#define LSMargin3 10

/// 字号规定
#define LSTipLabelFont [UIFont systemFontOfSize:18.0f]
#define LSBadNetworkLabelFont [UIFont systemFontOfSize:15.0f]
#define LSLoadingLabel [UIFont systemFontOfSize:16.0f]
#define LSRetryButtonColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

#define LSBadNetworkLabelColor  [UIColor colorWithWhite:0.400 alpha:1.000]


@implementation UITableView (Empty)

#pragma mark - startTip
- (void)setStartTip:(BOOL)startTip {
  if (startTip) {
    [self setupTipViews];
  }
    
  objc_setAssociatedObject(self, @selector(startTip), @(startTip),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 设置无网
- (void)setBadNetwork:(BOOL)badNetwork
{
    objc_setAssociatedObject(self, @selector(badNetwork), @(badNetwork),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  if (badNetwork) {
    if (self.startLoading) {
      [self stopLoadingAnimation];
    }
    self.tipView.hidden = NO;
    self.tipImageView.image = self.badNetworkImage;
    self.tipLabel.text = LSBadNetworkTitle1;
    self.badNetworkLabel.hidden = NO;
    self.retryButton.hidden = NO;
  } else {
    self.tipLabel.text = self.tipTitle;
    self.tipImageView.image = self.tipImage;
    self.badNetworkLabel.hidden = YES;
    self.retryButton.hidden = YES;
  }
  [self settingFrame];
    if (self.isFirstReloadData) {
        self.scrollEnabled=NO;
//        return;
    }
    self.scrollEnabled=!badNetwork;
    
}

- (void)ls_layoutSubviews {
  [self ls_layoutSubviews];
  CGFloat headerHeight = self.tableHeaderView.height;
  CGFloat y = self.contentInset.top + headerHeight;
  if (self.ls_topHeight !=y &&
      !CGRectEqualToRect(self.tipView.frame, CGRectZero)) {
    return;
  }
  [self settingFrame];
   
}

- (void)settingFrame {

//    self.tipLabel.backgroundColor=RandomColor;
//    self.badNetworkLabel.backgroundColor=RandomColor;
    
  CGFloat screenWidth = self.frame.size.width;
    CGFloat y = self.ls_topHeight;
  CGFloat realHeight = self.height - y - self.contentInset.bottom;
    
    
  self.tipView.frame = CGRectMake(0, y, self.frame.size.width, realHeight);
  // tip  Frame
  if (self.startTip) {
    CGSize size = self.bounds.size;
    if (self.startRetryButton && self.badNetwork) {
      CGFloat y =
          (realHeight - TipImageViewHeight - LSMargin1 - TipLabelHeight -
           LSMargin2 - BadNetworkLabelHeight - LSMargin3 - RetryButtonHeight) /
          2;
      self.tipImageView.frame =
          CGRectMake((size.width - TipImageViewWidth) / 2.0, y,
                     TipImageViewWidth, TipImageViewHeight);

    } else {
      CGFloat y =
          (realHeight - TipImageViewHeight - LSMargin1 - TipLabelHeight) / 2;
      self.tipImageView.frame =
          CGRectMake((size.width - TipImageViewWidth) / 2.0, y,
                     TipImageViewWidth, TipImageViewHeight);
    }
    self.tipLabel.frame =
        CGRectMake(0, CGRectGetMaxY(self.tipImageView.frame) + LSMargin1,
                   size.width, TipLabelHeight);
  }

  if (self.startRetryButton) {
    if (self.startTip) {

      self.badNetworkLabel.frame =
          CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame) + LSMargin2, screenWidth,
                     BadNetworkLabelHeight);

    } else {
      CGFloat y =
          (realHeight - BadNetworkLabelHeight - LSMargin3 - RetryButtonHeight) /
          2;
      CGFloat screenWidth = self.frame.size.width;
      self.badNetworkLabel.frame =
          CGRectMake(0, y, screenWidth, BadNetworkLabelHeight);
    }
    CGFloat maxY = CGRectGetMaxY(self.badNetworkLabel.frame);

    self.retryButton.frame =
        CGRectMake((screenWidth - RetryButtonWidth) / 2, maxY + LSMargin3,
                   RetryButtonWidth, RetryButtonHeight);
  }

  self.retryButton.backgroundColor =
      [UIColor colorWithRed:0.224 green:0.436 blue:0.471 alpha:1.000];
  /***********  设置loadingd frame   *********************/
  if (self.startLoading == NO) {
    return;
  }
  CGSize imageSize = [self.loadingImages.firstObject size];
  CGFloat margin = 20; //加载动画和加载label 间隔
  if (self.loadingTitle && self.loadingImages.count) {
    self.loadingImageView.frame = CGRectMake(
        (screenWidth - imageSize.width) / 2,
        y + (realHeight - imageSize.height - margin - LSLoadingLabelHeight) / 2,
        imageSize.width, imageSize.height);
    self.loadingLabel.frame =
        CGRectMake(0, CGRectGetMaxY(self.loadingImageView.frame) + margin,
                   screenWidth, LSLoadingLabelHeight);
    return;
  }
  if (self.loadingTitle) {
    self.loadingLabel.frame =
        CGRectMake(0, y + (realHeight - LSLoadingLabelHeight) / 2, screenWidth,
                   LSLoadingLabelHeight);
    return;
  }
  if (self.loadingImages.count) {
    self.loadingImageView.frame =
        CGRectMake((screenWidth - imageSize.width) / 2,
                   y + (realHeight - imageSize.height) / 2, imageSize.width,
                   imageSize.height);
  }
}
- (void)setupContentView {
  if (self.tipView) {
    return;
  }
  //不管开启哪项功能都得会创建tipView 初始化参数
  self.tipImage = [UIImage imageNamed:@"nomessage"];
  UIView *tipView = [[UIView alloc] init];
  tipView.backgroundColor = [UIColor colorWithWhite:0.913 alpha:1.000];

  self.tipView = tipView;
  [self addSubview:tipView];
}
- (void)setupTipViews {
  [self setupContentView];
  if (self.tipImageView) {
    return;
  }
  UILabel *tipLabel = [[UILabel alloc] init];
  tipLabel.textColor = [UIColor lightGrayColor];
  tipLabel.textAlignment = NSTextAlignmentCenter;
  [self.tipView addSubview:tipLabel];
  self.tipLabel = tipLabel;

  UIImageView *tipImageView = [[UIImageView alloc] initWithImage:self.tipImage];
  tipImageView.contentMode = UIViewContentModeCenter;
  [self.tipView addSubview:tipImageView];
  self.tipImageView = tipImageView;
  if (self.startRetryButton) {
    if (self.badNetworkLabel == nil) {
      [self setupBadNetworkViews];
    }
  }
}
- (void)retryClick {

    self.badNetwork = NO;
  if (self.startLoading) {
    self.tipView.hidden = YES;
    [self startLoadingAnimation];
  }
  if (self.retryBlock) {
    self.retryBlock();
  }
}
- (void)ls_reloaData {
  [self ls_reloaData];
   self.badNetwork = NO; //会重新改变frame
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

  if (self.isFirstReloadData) {
      CGFloat headerHeight = self.tableHeaderView.height;
      CGFloat y = self.contentInset.top + headerHeight;
      self.ls_topHeight=y;
    if (self.startLoading) {
      self.tipView.hidden = YES;
    }
  }
  if (!self.isFirstReloadData) {
      if (self.loadingImageView.isAnimating) {
          [self loading:NO];
      }
  }
 

  self.isFirstReloadData = NO;
}
void ls_swizzleMethod(Class class, SEL originalSel, SEL newSel) {
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

  ls_swizzleMethod([self class], @selector(reloadData),
                   @selector(ls_reloaData));
  ls_swizzleMethod([self class], @selector(willMoveToSuperview:),
                   @selector(ls_willMoveToSuperview:));

  ls_swizzleMethod([self class], @selector(layoutSubviews),
                   @selector(ls_layoutSubviews));
}
- (void)setupBadNetworkViews {

  [self setupContentView];
  self.badNetworkImage = [UIImage imageNamed:@"bad_network"];
  UILabel *badNetworkLabel = [[UILabel alloc] init];
  badNetworkLabel.textAlignment = NSTextAlignmentCenter;
  badNetworkLabel.text = LSBadNetworkTitle2;
  badNetworkLabel.textColor = LSBadNetworkLabelColor;
  badNetworkLabel.font = LSBadNetworkLabelFont;
  [self.tipView addSubview:badNetworkLabel];
  self.badNetworkLabel = badNetworkLabel;


  UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
  [button setTitle:@"重新加载" forState:UIControlStateNormal];
  button.titleLabel.font = [UIFont systemFontOfSize:16];
  [button setTitleColor:LSRetryButtonColor forState:UIControlStateNormal];
  button.radius = 3;
  [self.tipView addSubview:button];
  self.retryButton = button;
  [self.retryButton addTarget:self
                       action:@selector(retryClick)
             forControlEvents:UIControlEventTouchUpInside];
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
- (BOOL)badNetwork {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)startLoading {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setStartLoading:(BOOL)startLoading {
  objc_setAssociatedObject(self, @selector(startLoading), @(startLoading),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setupLoadingViews {
  if (self.loadingImageView) {
    return;
  }
  UIImageView *loadingImageView = [[UIImageView alloc] init];

  loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
  [self addSubview:loadingImageView];
  self.loadingImageView = loadingImageView;
}

- (void)ls_willMoveToSuperview:(UIView *)newSuperview {
  self.isFirstReloadData = YES;
  [self ls_willMoveToSuperview:newSuperview];
  self.loadingImageView.animationImages = self.loadingImages;
  if (self.startLoading) {
    [self startLoadingAnimation];
  }
}
- (void)setLoadingImages:(NSArray *)loadingImages {
  if (loadingImages.count > 0) {
    if (self.startLoading) {
      [self setupLoadingViews];
    }
  }
  objc_setAssociatedObject(self, @selector(loadingImages), loadingImages,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)loadingImages {
  return objc_getAssociatedObject(self, _cmd);
}
- (void)setLoadingImageView:(UIImageView *)loadingImageView {
  objc_setAssociatedObject(self, @selector(loadingImageView), loadingImageView,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImageView *)loadingImageView {
  return objc_getAssociatedObject(self, _cmd);
}
- (void)setLoadingLabel:(UILabel *)loadingLabel {
  objc_setAssociatedObject(self, @selector(loadingLabel), loadingLabel,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)loadingLabel {
  return objc_getAssociatedObject(self, _cmd);
}
- (void)setLoadingTitle:(NSString *)loadingTitle {

  if (loadingTitle.length > 0) {
    if (self.startLoading) {
      UILabel *loadingLabel = [[UILabel alloc] init];
      loadingLabel.text = loadingTitle;
      loadingLabel.textAlignment = NSTextAlignmentCenter;
      [self addSubview:loadingLabel];
      self.loadingLabel = loadingLabel;
    }
  }
  objc_setAssociatedObject(self, @selector(loadingTitle), loadingTitle,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)loadingTitle {
  return objc_getAssociatedObject(self, _cmd);
}
- (void)setIsFirstReloadData:(BOOL)isFirstReloadData {
  objc_setAssociatedObject(self, @selector(isFirstReloadData),
                           @(isFirstReloadData),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isFirstReloadData {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)hideLoading {
  [self stopLoadingAnimation];
  if (self.startTip) {
    self.tipView.hidden = NO;
  }
}
- (void)stopLoadingAnimation {
  [self loading:NO];
}
- (void)startLoadingAnimation {
  [self loading:YES];
}
- (void)loading:(BOOL)isLoading {
  if (self.startLoading == NO) {
    return;
  }
  self.loadingImageView.hidden = !isLoading;
  self.loadingLabel.hidden = !isLoading;
    
    if (self.badNetwork) {
        self.scrollEnabled=NO;
        
    }else{
        self.scrollEnabled = !isLoading;
    }
  if (isLoading) {

    [self.loadingImageView startAnimating];
  } else {
    [self.loadingImageView stopAnimating];
  }
}
- (void)setStartRetryButton:(BOOL)startRetryButton {
  if (startRetryButton) {
    [self setupBadNetworkViews];
  }
  objc_setAssociatedObject(self, @selector(startRetryButton),
                           @(startRetryButton),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)startRetryButton {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setBadNetworkImage:(UIImage *)badNetworkImage {
  objc_setAssociatedObject(self, @selector(badNetworkImage), badNetworkImage,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)badNetworkImage {
  return objc_getAssociatedObject(self, _cmd);
}
- (void)setLs_topHeight:(CGFloat)ls_topHeight {
  objc_setAssociatedObject(self, @selector(ls_topHeight), @(ls_topHeight),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)ls_topHeight {
  return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
@end
