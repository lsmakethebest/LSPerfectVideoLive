//
//  LSTitleScrollView.h
//  LSScrollPage
//
//  Created by 刘松 on 16/5/8.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSScrollPage;

@interface LSTitleScrollView : UIScrollView

@property(nonatomic,strong) UIColor *currentTitleColor;
@property(nonatomic,strong) UIColor *defaultTitleColor;
@property (nonatomic, strong) NSMutableArray* titles;
@property (nonatomic,assign) CGFloat itemWidth;


@property (nonatomic,weak) LSScrollPage *scrollPage;

#pragma mark -  用于给ScrollPage滚动完成调用
-(void)clickIndexFromScrollPage:(NSInteger)index;


#pragma mark - 用于外界用代码调用点击第几个标签
-(void)clickIndex:(NSInteger)index;


#pragma mark - 设置红线偏移量
-(void)setContentOffsetScale:(CGFloat)contentOffsetScale;


@end
