
//
//  KCRenderButton.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/14.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "KCRenderButton.h"

@implementation KCRenderButton

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
}
@end
