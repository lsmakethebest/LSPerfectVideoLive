


//
//  RightImageButton.m
//  kuaichengwuliu
//
//  Created by zhz on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "RightImageButton.h"

@implementation RightImageButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x=23;
    self.titleLabel.y=(self.height-self.titleLabel.height)/2;
    
    self.imageView.x=self.width-10;
    self.imageView.y=(self.height-self.imageView.height)/2;
    
    
    
}

@end
