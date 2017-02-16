//
//  UIImage+LSExtension.h
//  至美微博
//
//  Created by ls on 15/10/4.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LSExtension)

#pragma mark -  加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

#pragma mark - 图片拉伸
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

#pragma mark -  图片高斯模糊
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;

#pragma mark - 颜色转化为图像
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - 自动缩放到指定大小
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

#pragma mark - 保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

@end
