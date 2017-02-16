//
//  LSScrollPage.m
//  LSScrollPage
//
//  Created by 刘松 on 16/5/8.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSScrollPage.h"

#define Width self.frame.size.width
#define Height self.frame.size.height

@interface LSScrollPage () <UIScrollViewDelegate>

@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic, strong) LSContentController *leftController;
@property(nonatomic, strong) LSContentController *midController;
@property(nonatomic, strong) LSContentController *rightController;
@property(nonatomic, strong) NSMutableDictionary *contentOffsets; //存放每个界面的contentOffset
@property(nonatomic, assign) NSInteger currentPage;


@end

@implementation LSScrollPage
{
CGFloat lastPointX;
NSInteger lastIndex;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
      lastIndex=0;
      lastPointX=0.0f;
    [self initViews];
  }
  return self;
}
- (NSMutableDictionary *)contentOffsets {
  if (_contentOffsets == nil) {
    _contentOffsets = [NSMutableDictionary dictionary];
  }
  return _contentOffsets;
}
/*
 初始化视图
 */
- (void)initViews {
  //存放内容的scrollView
  UIScrollView *scrollView = [[UIScrollView alloc] init];
  scrollView.backgroundColor = [UIColor colorWithRed:245 / 255.0
                                               green:245 / 255.0
                                                blue:245 / 255.0
                                               alpha:1.0];
  scrollView.pagingEnabled = YES;
  scrollView.showsHorizontalScrollIndicator = NO;
  scrollView.delegate = self;
  scrollView.scrollsToTop = NO;
    scrollView.bounces=NO;
  [self addSubview:scrollView];
  self.scrollView = scrollView;
}
/*
 创建内容控制器
 */
- (LSContentController *)addController {
  LSContentController *controller = [[self.contentClass alloc] initWithStyle:(UITableViewStyleGrouped)];
  //当tableView进行刷新数据时禁止滑动
  __weak typeof(self) weakSelf = self;
  controller.actionBlock = ^(BOOL success) {
    weakSelf.scrollView.scrollEnabled = success;
  };
  [self.scrollView addSubview:controller.view];
  return controller;
}
#pragma mark - 赋值
- (void)setModels:(NSArray *)models {
  _models = models;
  if (models.count <= 2) {
    self.leftController = [self addController];
    self.midController = [self addController];
  } else {
    self.leftController = [self addController];
    self.midController = [self addController];
    self.rightController = [self addController];
  }
  self.scrollView.contentSize = CGSizeMake(Width * models.count, 0);
  [self setControllerViewFrame];
  //设置内容scrollView
  for (int i = 0; i < self.models.count; i++) {
    [self.contentOffsets setObject:@(0) forKey:@(i)];
  }
  [self relodataNeedRefresh:YES scrollTop:NO];
    [self setStatusBarScrollTop];
}
/*
 设置内容控制器view的frame
 */
- (void)setControllerViewFrame {
    
    if (self.models.count<=3) {
        self.leftController.view.frame = CGRectMake(0, 0, Width, Height);
        self.midController.view.frame = CGRectMake(Width, 0, Width, Height);
        self.rightController.view.frame = CGRectMake(Width * 2, 0, Width, Height);
        return;
    }
  if (self.currentPage == 0) {
    self.leftController.view.frame = CGRectMake(0, 0, Width, Height);
    self.midController.view.frame = CGRectMake(Width, 0, Width, Height);
    self.rightController.view.frame = CGRectMake(Width * 2, 0, Width, Height);

  } else if (self.currentPage == self.models.count - 1) {
    self.leftController.view.frame =
        CGRectMake(Width * (self.models.count - 3), 0, Width, Height);
    self.midController.view.frame =
        CGRectMake(Width * (self.models.count - 2), 0, Width, Height);
    self.rightController.view.frame =
        CGRectMake(Width * (self.models.count - 1), 0, Width, Height);
  } else {
    self.leftController.view.frame =
        CGRectMake(Width * (self.currentPage - 1), 0, Width, Height);
    self.midController.view.frame =
        CGRectMake(Width * self.currentPage, 0, Width, Height);
    self.rightController.view.frame =
        CGRectMake(Width * (self.currentPage + 1), 0, Width, Height);
  }
}

- (void)saveContentOffset {
  NSInteger page = self.currentPage;
  if (page == 0) {
    [self.contentOffsets
        setObject:@(self.leftController.tableView.contentOffset.y)
           forKey:@(page)];
  } else if (page != self.models.count - 1) {

    [self.contentOffsets
        setObject:@(self.midController.tableView.contentOffset.y)
           forKey:@(page)];
  } else {
    [self.contentOffsets
        setObject:@(self.rightController.tableView.contentOffset.y)
           forKey:@(page)];
  }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  lastPointX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat x = scrollView.contentOffset.x;
  CGFloat width = scrollView.frame.size.width;
    
    BOOL scrollRight=YES;
    if (x <=lastPointX) {
        scrollRight=NO;
    }
  //已经到最后一页了
  if (scrollRight&&
      self.currentPage == (self.models.count - 1)&&x>=width*(self.models.count-1)) {
    return;
  }
  //已经到第一页了
  if (scrollRight==NO && self.currentPage == 0&&x<=0) {
    return;
  }
    [self.titleScrollView setContentOffsetScale:x / scrollView.contentSize.width];

  if (scrollRight) {
    //    NSLog(@"向右滚动");
    CGFloat expectX = (self.currentPage + 1) * width;
    if (x >= expectX) {
      //开始交换
      [self saveContentOffset];
        self.currentPage++;
        if (self.models.count >3) {
            [self switchRight];
            [self setControllerViewFrame];
        }
      [self relodataNeedRefresh:NO scrollTop:NO];
        [self setStatusBarScrollTop];
    }

  } else {
    //    NSLog(@"向左滚动");
    CGFloat expectX = (self.currentPage - 1) * width;
    if (x <= expectX) {
      //开始交换
      [self saveContentOffset];
        self.currentPage--;
        if (self.models.count>3) {
            [self switchLeft];
            [self setControllerViewFrame];
        }
      [self relodataNeedRefresh:NO scrollTop:NO];
        [self setStatusBarScrollTop];
    }
  }

  lastPointX = scrollView.contentOffset.x;
//    NSLog(@"11111111111111111111111");
}

/*
 刷新数据 在点击时needRefresh为YES  scrollTop为点击的是当前页面会滚动到顶部
 */
- (void)relodataNeedRefresh:(BOOL)needRefresh scrollTop:(BOOL)scrollTop {

  if (self.models.count <= 2) { //小于等于2个
    [self handleCountEqualTwoDateWithNeedRefresh:needRefresh
                                       scrollTop:scrollTop];
    return;
  }
  if (self.models.count == 3) { // 3个
    [self handleCountEqualThreeDateWithNeedRefresh:needRefresh
                                         scrollTop:scrollTop];
    return;
  }
  //多个
  [self handleCountDateWithNeedRefresh:needRefresh scrollTop:scrollTop];
}

- (void)handleCountDateWithNeedRefresh:(BOOL)needRefresh
                             scrollTop:(BOOL)scrollTop {
  if (self.currentPage <= 1) {
      
      if (self.currentPage==0) {
          [self.leftController setData:self.models[0]
                           needRefresh:needRefresh
                             scrollTop:scrollTop
                       contentOffset_Y:[self.contentOffsets[@0] floatValue]];
          
          [self.midController setData:self.models[1]
                          needRefresh:NO
                            scrollTop:NO
                      contentOffset_Y:[self.contentOffsets[@1] floatValue]];
          [self.rightController setData:self.models[2]
                            needRefresh:NO
                              scrollTop:NO
                        contentOffset_Y:[self.contentOffsets[@2] floatValue]];
      }else{
      
          [self.leftController setData:self.models[0]
                           needRefresh:NO
                             scrollTop:NO
                       contentOffset_Y:[self.contentOffsets[@0] floatValue]];
          
          [self.midController setData:self.models[1]
                          needRefresh:needRefresh
                            scrollTop:scrollTop
                      contentOffset_Y:[self.contentOffsets[@1] floatValue]];
          [self.rightController setData:self.models[2]
                            needRefresh:NO
                              scrollTop:NO
                        contentOffset_Y:[self.contentOffsets[@2] floatValue]];
      }
   
  } else if (self.currentPage == self.models.count - 1 ||
             self.currentPage == self.models.count - 2) {

      
      if (self.currentPage==self.models.count-1) {
          [self.leftController setData:self.models[self.models.count - 3]
                           needRefresh:NO
                             scrollTop:NO
                       contentOffset_Y:[self.contentOffsets[@(self.models.count - 3)]
                                        doubleValue]];
          
          [self.midController setData:self.models[self.models.count - 2]
                          needRefresh:NO
                            scrollTop:NO
                      contentOffset_Y:[self.contentOffsets[@(self.models.count - 2)]
                                       doubleValue]];
          [self.rightController setData:self.models[self.models.count - 1]
                            needRefresh:needRefresh
                              scrollTop:scrollTop
                        contentOffset_Y:[self.contentOffsets[@(self.models.count - 1)]
                                         doubleValue]];
      }else{
      
        
          [self.leftController setData:self.models[self.models.count - 3]
                           needRefresh:NO
                             scrollTop:NO
                       contentOffset_Y:[self.contentOffsets[@(self.models.count - 3)]
                                        doubleValue]];
          
          [self.midController setData:self.models[self.models.count - 2]
                          needRefresh:needRefresh
                            scrollTop:scrollTop
                      contentOffset_Y:[self.contentOffsets[@(self.models.count - 2)]
                                       doubleValue]];
          [self.rightController setData:self.models[self.models.count - 1]
                            needRefresh:NO
                              scrollTop:NO
                        contentOffset_Y:[self.contentOffsets[@(self.models.count - 1)]
                                         doubleValue]];
      }
  } else {

    [self.leftController setData:self.models[self.currentPage - 1]
                     needRefresh:NO
                       scrollTop:NO
                 contentOffset_Y:[self.contentOffsets[@(self.currentPage - 1)]
                                     doubleValue]];

    [self.midController
                setData:self.models[self.currentPage]
            needRefresh:needRefresh
              scrollTop:scrollTop
        contentOffset_Y:[self.contentOffsets[@(self.currentPage)] doubleValue]];
    [self.rightController setData:self.models[self.currentPage + 1]
                      needRefresh:NO
                        scrollTop:NO
                  contentOffset_Y:[self.contentOffsets[@(self.currentPage + 1)]
                                      doubleValue]];
  }
}
- (void)handleCountEqualTwoDateWithNeedRefresh:(BOOL)needRefresh
                                     scrollTop:(BOOL)scrollTop {

  if (self.currentPage == 0) {
    [self.leftController setData:self.models[0]
                     needRefresh:needRefresh
                       scrollTop:scrollTop
                 contentOffset_Y:[self.contentOffsets[@0] doubleValue]];

    [self.midController setData:self.models[1]
                    needRefresh:NO
                      scrollTop:NO
                contentOffset_Y:[self.contentOffsets[@1] doubleValue]];
  } else {
    [self.leftController setData:self.models[0]
                     needRefresh:NO
                       scrollTop:NO
                 contentOffset_Y:[self.contentOffsets[@0] doubleValue]];

    [self.midController setData:self.models[1]
                    needRefresh:needRefresh
                      scrollTop:scrollTop
                contentOffset_Y:[self.contentOffsets[@1] doubleValue]];
  }
}
- (void)handleCountEqualThreeDateWithNeedRefresh:(BOOL)needRefresh
                                       scrollTop:(BOOL)scrollTop {

  if (self.currentPage == 0) {
    [self.leftController setData:self.models[0]
                     needRefresh:needRefresh
                       scrollTop:scrollTop
                 contentOffset_Y:[self.contentOffsets[@0] doubleValue]];

    [self.midController setData:self.models[1]
                    needRefresh:NO
                      scrollTop:NO
                contentOffset_Y:[self.contentOffsets[@1] doubleValue]];
    [self.rightController setData:self.models[2]
                      needRefresh:NO
                        scrollTop:NO
                  contentOffset_Y:[self.contentOffsets[@2] doubleValue]];
  } else if (self.currentPage == 1) {
    [self.leftController setData:self.models[0]
                     needRefresh:NO
                       scrollTop:NO
                 contentOffset_Y:[self.contentOffsets[@0] doubleValue]];

    [self.midController setData:self.models[1]
                    needRefresh:needRefresh
                      scrollTop:scrollTop
                contentOffset_Y:[self.contentOffsets[@1] doubleValue]];
    [self.rightController setData:self.models[2]
                      needRefresh:NO
                        scrollTop:NO
                  contentOffset_Y:[self.contentOffsets[@2] doubleValue]];

  } else {
    [self.leftController setData:self.models[0]
                     needRefresh:NO
                       scrollTop:NO
                 contentOffset_Y:[self.contentOffsets[@0] doubleValue]];

    [self.midController setData:self.models[1]
                    needRefresh:NO
                      scrollTop:NO
                contentOffset_Y:[self.contentOffsets[@1] doubleValue]];
    [self.rightController setData:self.models[2]
                      needRefresh:needRefresh
                        scrollTop:scrollTop
                  contentOffset_Y:[self.contentOffsets[@2] doubleValue]];
  }
}
/*
 设置点击状态栏tableView可以滚动到顶部
 */
- (void)setStatusBarScrollTop {
  if (self.currentPage == 0) {
    self.leftController.tableView.scrollsToTop = YES;
    self.midController.tableView.scrollsToTop = NO;
    self.rightController.tableView.scrollsToTop = NO;
  } else if (self.currentPage != self.models.count - 1) {
    self.leftController.tableView.scrollsToTop = NO;
    self.midController.tableView.scrollsToTop = YES;
    self.rightController.tableView.scrollsToTop = NO;
  } else {
    self.leftController.tableView.scrollsToTop = NO;
    self.midController.tableView.scrollsToTop = NO;
    self.rightController.tableView.scrollsToTop = YES;
  }
}
- (void)switchLeft {

  LSContentController *tmp = self.rightController;
  self.rightController = self.midController;
  self.midController = self.leftController;
  self.leftController = tmp;
}
- (void)switchRight {

  LSContentController *tmp = self.leftController;
  self.leftController = self.midController;
  self.midController = self.rightController;
  self.rightController = tmp;
}
- (void)layoutSubviews {
  [super layoutSubviews];
  self.scrollView.frame = CGRectMake(0, 0, Width, Height);
  [self setControllerViewFrame];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (lastIndex==index) {
        return;
    }
//    NSLog(@"Index======%d",index);
    [self.titleScrollView setContentOffsetScale:scrollView.contentOffset.x /
     scrollView.contentSize.width];
  [self relodataNeedRefresh:YES scrollTop:NO];
  lastPointX = scrollView.contentOffset.x;
  [self.titleScrollView clickIndexFromScrollPage:index];
  self.currentPage = index;
    
    lastIndex=index;
}
- (void)updateViewLocationWithIndex:(int)pageIndex {
  //点击的是当前页面
  int tag = pageIndex;
  if (tag == self.currentPage) { //点击的是当前页按钮
    [self relodataNeedRefresh:NO scrollTop:YES];
    return;
  }

  //点击的不是当前页面

  //保存上一界面contentOffset
  [self saveContentOffset];

  //当点击切换页面时取消上个界面的网络操作
  //同时让scrollView可以滚动
  self.scrollView.scrollEnabled = YES;
  if (self.currentPage == 0) {
    [self.leftController cancelNetworkingOperation];
  } else if (self.currentPage != self.models.count - 1) {
    [self.midController cancelNetworkingOperation];
  } else {
    [self.rightController cancelNetworkingOperation];
  }
    [self.leftController cancelNetworkingOperation];
    [self.midController cancelNetworkingOperation];
    [self.rightController cancelNetworkingOperation];
 lastIndex= self.currentPage = tag;
  self.scrollView.contentOffset = CGPointMake(Width * tag, 0);
  [self setControllerViewFrame];
  [self relodataNeedRefresh:YES scrollTop:NO];
  [self setStatusBarScrollTop];
}


@end
