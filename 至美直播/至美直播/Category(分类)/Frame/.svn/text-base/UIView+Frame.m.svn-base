//
//  UIView+Frame.m
//  至美微博
//
//  Created by ls on 15/10/4.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}
-(CGPoint)origin
{
    return self.frame.origin;
    
}
-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin=origin;
    self.frame = frame;
}
//返回当前view所在的控制器
- (UIViewController*) viewController
{
    for (UIResponder *res=self.nextResponder;res!=nil ;res=res.nextResponder) {
        if ([res isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)res;
        }
    }

    return nil;
}
-(void)setRadius:(CGFloat)radius
{
    self.layer.cornerRadius=radius;
    self.layer.masksToBounds=YES;
}
-(void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderWidth=0.5;
    self.layer.borderColor=borderColor.CGColor;
}
@end
