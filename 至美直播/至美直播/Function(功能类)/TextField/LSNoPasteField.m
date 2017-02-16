




//
//  LSNoPasteField.m
//  driver
//
//  Created by 刘松 on 16/8/29.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "LSNoPasteField.h"

@implementation LSNoPasteField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
