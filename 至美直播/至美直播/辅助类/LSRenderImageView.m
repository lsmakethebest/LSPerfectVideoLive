

//
//  LSRenderImageView.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSRenderImageView.h"

@implementation LSRenderImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


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
