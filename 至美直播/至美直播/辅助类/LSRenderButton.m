
//
//  LSRenderButton.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSRenderButton.h"

@implementation LSRenderButton

-(void)setCorner:(CGFloat)corner
{
    _corner=corner;
    self.radius=corner;
    self.clipsToBounds=YES;
}
-(void)setIBorderColor:(UIColor *)iBorderColor
{
    _iBorderColor=iBorderColor;
    self.layer.borderWidth=1;
    self.layer.borderColor=iBorderColor.CGColor;
    
}

@end
