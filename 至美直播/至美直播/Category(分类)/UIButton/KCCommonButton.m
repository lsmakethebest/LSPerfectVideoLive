



//
//  KCCommonButton.m
//  driver
//
//  Created by 刘松 on 16/7/27.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCCommonButton.h"

@implementation KCCommonButton


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setdata];
    }
    return self;
}
-(void)setdata
{
    [self setBackgroundImage:[UIImage imageNamed:@"blueBack"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"blueBackDisabled"] forState:UIControlStateDisabled];
    [self setBackgroundImage:[UIImage imageNamed:@"blueBackHighlighted"] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.000 alpha:0.604] forState:UIControlStateDisabled];
    self.layer.cornerRadius=3;
    self.clipsToBounds=YES;
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self setdata];
    }
    return self;
}


@end
