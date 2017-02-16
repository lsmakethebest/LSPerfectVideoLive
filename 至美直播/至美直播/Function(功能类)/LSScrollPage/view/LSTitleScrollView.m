

//
//  LSTitleScrollView.m
//  LSScrollPage
//
//  Created by 刘松 on 16/5/8.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSScrollPage.h"
#import "LSTitleScrollView.h"
#define TitleMargin 3
#define LineHeight 2
#define ButtonWidth 40


@interface LSTitleScrollView ()
@property(nonatomic, strong)
    NSMutableArray *titleButtons; //存放顶部标题button的数组
@property(nonatomic, weak) UIButton *selectedBtn;
@property(nonatomic, weak) UIView *line;
@property(nonatomic, assign) BOOL isUpdatePageLocation; //是否更新page位置
@property(nonatomic, assign) BOOL isFull;

@end
@implementation LSTitleScrollView
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollsToTop = NO;
    self.itemWidth = 80;
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    self.line = line;
    self.defaultTitleColor = [UIColor blackColor];
    self.currentTitleColor = [UIColor redColor];
    self.isUpdatePageLocation = YES;
  }
  return self;
}
- (NSMutableArray *)titleButtons {
  if (!_titleButtons) {
    _titleButtons = [NSMutableArray array];
  }
  return _titleButtons;
}
- (void)setCurrentTitleColor:(UIColor *)currentTitleColor {
  _currentTitleColor = currentTitleColor;
  self.line.backgroundColor = currentTitleColor;
}
- (void)setTitles:(NSMutableArray *)titles {
  _titles = titles;
  self.isFull = YES;
  if (self.frame.size.width < self.itemWidth * titles.count) {
    self.contentSize = CGSizeMake(self.itemWidth * titles.count, 0);
    self.line.frame = CGRectMake(0, self.frame.size.height - LineHeight,
                                 self.itemWidth, LineHeight);
    for (int i = 0; i < titles.count; i++) {
      UIButton *titleBtn = [[UIButton alloc] init];
      titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
      NSString *title = titles[i];
      [titleBtn setTitle:title forState:UIControlStateNormal];
      [titleBtn addTarget:self
                    action:@selector(buttonClick:)
          forControlEvents:UIControlEventTouchUpInside];
      titleBtn.tag = i;
      titleBtn.frame = CGRectMake(self.itemWidth * i, 0, self.itemWidth,
                                  self.frame.size.height - LineHeight);
      [self addSubview:titleBtn];
      [self.titleButtons addObject:titleBtn];
      [titleBtn setTitleColor:self.defaultTitleColor
                     forState:UIControlStateNormal];
      [titleBtn setTitleColor:self.currentTitleColor
                     forState:UIControlStateSelected];
    }
  } else {
    self.isFull = NO;
    CGFloat width = self.frame.size.width / titles.count;
    self.line.frame =
        CGRectMake(0, self.frame.size.height - LineHeight, width, LineHeight);
    for (int i = 0; i < titles.count; i++) {
      UIButton *titleBtn = [[UIButton alloc] init];
      titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
      NSString *title = titles[i];
      [titleBtn setTitle:title forState:UIControlStateNormal];
      [titleBtn addTarget:self
                    action:@selector(buttonClick:)
          forControlEvents:UIControlEventTouchUpInside];
      titleBtn.tag = i;
      titleBtn.frame =
          CGRectMake(width * i, 0, width, self.frame.size.height - LineHeight);
      [self addSubview:titleBtn];
      [self.titleButtons addObject:titleBtn];
      [titleBtn setTitleColor:self.defaultTitleColor
                     forState:UIControlStateNormal];
      [titleBtn setTitleColor:self.currentTitleColor
                     forState:UIControlStateSelected];
    }
  }

  self.isUpdatePageLocation = YES;
  UIButton *btn = self.titleButtons[0];
  btn.selected = YES;
  self.selectedBtn = btn;
}
- (void)clickIndexFromScrollPage:(NSInteger)index {
  self.isUpdatePageLocation = NO;
  [self buttonClick:self.titleButtons[index]];
  [self updateLocationWith:index];
}

- (void)updateLocationWith:(NSInteger)index {
  if (!self.isFull)
    return;

  CGRect frame = [self.titleButtons[index] frame];
  CGFloat width = self.frame.size.width;
  if (frame.origin.x <
      (width - frame.size.width) / 2) { //在左侧了不能往中间滚动
    [self setContentOffset:CGPointZero animated:YES];
  } else if (self.contentSize.width - (frame.origin.x + frame.size.width) <
             (width - frame.size.width) / 2-ButtonWidth/2) { //在右侧了不能往中间滚动
    [self setContentOffset:CGPointMake(self.contentSize.width - width, 0)
                  animated:YES];
  } else {
    [self
        setContentOffset:CGPointMake(
                             frame.origin.x - (width - frame.size.width) / 2-ButtonWidth/2, 0)
                animated:YES];
  }
}
- (void)buttonClick:(UIButton *)button {

  self.selectedBtn.selected = NO;
  button.selected = YES;
  self.selectedBtn = button;
  int tag = (int)button.tag;
  [self updateLocationWith:tag];
    CGFloat width = self.frame.size.width / self.titleButtons.count;
  if (self.isFull) {
      self.line.frame = CGRectMake(self.itemWidth*tag,
                                   self.frame.size.height - LineHeight,
                                   self.itemWidth, LineHeight);
  }else{
      self.line.frame = CGRectMake(width * tag, self.frame.size.height - LineHeight,
                                   width, LineHeight);
  }
  if (self.isUpdatePageLocation) {
    [self.scrollPage updateViewLocationWithIndex:tag];
  }
  self.isUpdatePageLocation = YES;
}
- (void)setContentOffsetScale:(CGFloat)contentOffsetScale {
  if (!self.isFull) { //宽度够用不用滑动
    self.line.frame =
        CGRectMake(self.frame.size.width * contentOffsetScale,
                   self.frame.size.height - LineHeight,
                   self.frame.size.width / self.titles.count, LineHeight);
  } else {
    self.line.frame = CGRectMake(self.contentSize.width * contentOffsetScale,
                                 self.frame.size.height - LineHeight,
                                 self.itemWidth, LineHeight);
  }
}
- (void)clickIndex:(NSInteger)index {
  [self buttonClick:self.titleButtons[index]];
}

@end
