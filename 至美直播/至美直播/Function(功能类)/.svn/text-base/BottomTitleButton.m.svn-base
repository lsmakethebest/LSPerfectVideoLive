



//
//  BottomTitleButton.m
//  kuaichengwuliu
//
//  Created by zhz on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "BottomTitleButton.h"

#define Height 20
@implementation BottomTitleButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    if (self.imageView.image.size.width>100) {
        self.imageView.size=CGSizeMake(160, 100);
    }else{
        self.imageView.size=self.imageView.image.size;
    }
    self.imageView.clipsToBounds = YES;
    [self.imageView.layer setCornerRadius:5];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.x=(self.width-self.imageView.width)/2;
//    self.imageView.y=10;
    CGSize  size= [self.currentTitle sizeOfTextWithMaxSize:CGSizeMake(self.width, CGFLOAT_MAX) font:self.titleLabel.font];
    self.titleLabel.size=size;
    self.titleLabel.x=(self.width-self.titleLabel.width)/2;
    self.titleLabel.y=self.height-self.titleLabel.height + 45;
}
@end
