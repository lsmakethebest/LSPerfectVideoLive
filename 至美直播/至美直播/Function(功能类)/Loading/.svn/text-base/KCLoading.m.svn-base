

//
//  KCLoading.m
//  driver
//
//  Created by 刘松 on 16/7/7.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCLoading.h"
#import "MSWeakTimer.h"
@interface KCLoading ()

@property(nonatomic, weak) UIImageView *imageView;
@property(nonatomic, strong) MSWeakTimer *timer;
@property(nonatomic, assign) int number;

@end
@implementation KCLoading
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setupViews];
  }
  return self;
}
- (void)setupViews {
  self.timer =
      [MSWeakTimer scheduledTimerWithTimeInterval:0.3
                                           target:self
                                         selector:@selector(changePic)
                                         userInfo:nil
                                          repeats:YES
                                    dispatchQueue:dispatch_get_main_queue()];
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.contentMode = UIViewContentModeCenter;
  self.number = 1;
  imageView.image = [UIImage imageNamed:@"loading_1"];
  [self addSubview:imageView];
  self.imageView = imageView;
}
+ (void)show {
  KCLoading *loading = [[KCLoading alloc] init];
  UIView *view = [UIApplication sharedApplication].keyWindow;
  loading.frame = [UIScreen mainScreen].bounds;
  [view addSubview:loading];
}
+ (void)showToView:(UIView *)view {
  KCLoading *loading = [[KCLoading alloc] init];
  loading.frame = view.bounds;
  [view addSubview:loading];
}
+ (void)hideForView:(UIView *)view {
  KCLoading *loading = [self HUDForView:view];
  [UIView animateWithDuration:0.5
      animations:^{
        loading.imageView.alpha = 0;
      }
      completion:^(BOOL finished) {
        [loading removeFromSuperview];
      }];
}
+ (void)hide {
  UIView *view = [UIApplication sharedApplication].keyWindow;
  KCLoading *loading = [self HUDForView:view];
  [UIView animateWithDuration:0.5
      animations:^{
        loading.imageView.alpha = 0;

      }
      completion:^(BOOL finished) {
        [loading removeFromSuperview];
      }];
}
+ (instancetype)HUDForView:(UIView *)view {
  NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
  for (UIView *subview in subviewsEnum) {
    if ([subview isKindOfClass:self]) {
      return (KCLoading *)subview;
    }
  }
  return nil;
}
- (void)layoutSubviews {
  [super layoutSubviews];
  if ([self.superview.nextResponder isKindOfClass:[UIViewController class]]) {
    self.imageView.frame =
        CGRectMake((self.width - 80) / 2, (self.height - 64 - 40) / 2, 80, 40);
  } else {
    self.imageView.center = self.center;
  }
}
- (void)changePic {
  self.number++;
  if (self.number == 6) {
    self.number = 1;
  }
  self.imageView.image = [UIImage
      imageNamed:[NSString stringWithFormat:@"loading_%d", self.number]];
}
- (void)dealloc {
}
@end
