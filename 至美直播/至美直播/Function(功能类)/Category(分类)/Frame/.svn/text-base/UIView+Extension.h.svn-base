//
//  UIView+Frame.h
//  至美微博
//
//  Created by ls on 15/10/4.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性，和方法的实现
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, assign) CGPoint origin;

//返回当前view所在的控制器
- (UIViewController *)viewController;

//	删除所有子对象
- (void)removeAllSubviews;

// 判断一个控件是否真正显示在主窗口
- (BOOL)isShowingOnKeyWindow;

// 快速返回对应的Xib转换后的View
+ (instancetype)viewFromXib;

@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, strong) UIColor *borderColor;


@end
