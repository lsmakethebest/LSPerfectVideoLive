

//
//  RightTitleButton.m
//  kuaichengwuliu
//
//  Created by zhz on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "RightTitleButton.h"

@implementation RightTitleButton
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x=self.width-self.titleLabel.width;
}

@end
