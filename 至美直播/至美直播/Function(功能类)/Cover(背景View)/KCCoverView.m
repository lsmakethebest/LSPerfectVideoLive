
//
//  KCCoverView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "KCCoverView.h"


@interface KCCoverView ()

@property (nonatomic,weak) UIView *targetView;

@end

@implementation KCCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.225];
    }
    return self;
}
//显示
+(void)showTargetView:(UIView*)targetView
{
    UIView *view=[[[UIApplication sharedApplication] windows]firstObject] ;
    KCCoverView *cover= [[KCCoverView alloc]init];
    cover.frame=view.bounds;
    cover.targetView=targetView;
    targetView.x=0;
    targetView.width=cover.width;
    targetView.y=cover.height-targetView.height;
    [cover addSubview:targetView];
    [view addSubview:cover];
    targetView.y=cover.height;
    
    [UIView animateWithDuration:0.2 animations:^{
    targetView.y=cover.height-targetView.height;
    }];
    
}

/// 消失
-(void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.targetView.y=self.height;
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

-(void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    self.alpha=0;
}
-(void)didMoveToWindow
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;;
    }];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
-(void)dealloc
{

}

@end
