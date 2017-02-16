

//
//  LSProgressButton.m
//  至美直播
//
//  Created by 刘松 on 2017/1/16.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSProgressButton.h"

#define LSProgressButtonMargin 5.0f

#define LSProgressButtonLineWidth 4.0f

#define LSProgressButtonTotalTime 10.0f

#define LSProgressButtonTimeInterval 0.1f

#define LSProgressButtonNormalColor [RGB(0xE7E7E3) colorWithAlphaComponent:0.8]

#define LSProgressButtonProgressColor RGB(0xf53536)


@interface LSProgressButton ()

@property (nonatomic,weak) CAShapeLayer *shapeLayer;

@property(nonatomic,strong) MSWeakTimer *timer;

@property (nonatomic,copy) LSProgressButtonBlock  block;

//是否正在录像
@property (nonatomic,assign) BOOL isRecord;
@property (nonatomic,assign) BOOL success;


@end

@implementation LSProgressButton



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    
    return self;
}

-(void)setupViews
{
    
    self.backgroundColor=[[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    self.layer.cornerRadius=self.bounds.size.width/2;
    
    [self createShapeLayer:[UIColor whiteColor] progress:NO];
    self.shapeLayer=[self createShapeLayer:LSProgressButtonProgressColor progress:YES];
    self.shapeLayer.strokeEnd=.0f;
     [LSNotificationCenter addObserver:self selector:@selector(cancel) name:LSWillResignActiveNotification object:nil];
}
-(void)cancel
{
    if (!self.success&&self.isRecord) {
        [self hideLayer];
        [self handleWithType:LSProgressButtonBlockTypeCancel];
        self.isRecord=NO;
        self.success=NO;
    }
    
    
}
-(CAShapeLayer*)createShapeLayer:(UIColor*)color progress:(BOOL)progress
{
    CGFloat lineWidth=LSProgressButtonLineWidth;
    CGFloat margin=LSProgressButtonMargin;
    //使红色线里圈完全盖住白线
    if (progress) {
        lineWidth+=0.3;
        margin-=0.2;
    }
    
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];

    shapeLayer.lineCap =kCALineCapRound;
    shapeLayer.strokeColor=color.CGColor;
    shapeLayer.lineWidth=lineWidth;
    shapeLayer.lineJoin=kCALineJoinRound;
    shapeLayer.backgroundColor=[UIColor clearColor].CGColor;
    shapeLayer.fillColor=[UIColor clearColor].CGColor;
    
    
    CGFloat width=self.bounds.size.width+2*margin+lineWidth*2;
    
    shapeLayer.position=CGPointMake(-(width/2-self.frame.size.width/2), -(width/2-self.frame.size.width/2));
    
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 startAngle:M_PI*3/2 endAngle:M_PI*7/2 clockwise:YES];
    
    shapeLayer.path=path.CGPath;
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isRecord) {//则代表停止
        [self complete];
        return;
    }
    self.isRecord=YES;
    self.success=NO;
    self.backgroundColor = LSProgressButtonProgressColor;
    if (self.block) {
        self.block(LSProgressButtonBlockTypeStart);
    }
    self.timer=[MSWeakTimer scheduledTimerWithTimeInterval:LSProgressButtonTimeInterval target:self selector:@selector(update) userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue()];
    
}
-(void)update
{

    
//     LSProgressButtonTotalTime
    self .shapeLayer.strokeEnd+=0.01;
    if (self.shapeLayer.strokeEnd>=1) {
        [self complete];
    }
}

-(void)complete
{
    [self hideLayer];
    [self handleWithType:LSProgressButtonBlockTypeEnd];
    self.isRecord=NO;
    self.success=YES;
}

-(void)hideLayer
{
    [self.timer invalidate];
    self.timer=nil;
    //清除之前没有完成的隐式动画
    [self.shapeLayer removeAllAnimations];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.shapeLayer.strokeEnd=.0f;
    [CATransaction commit];
    self.backgroundColor= LSProgressButtonNormalColor;
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    if (!self.isRecord) {
//        [self hideLayer];
//        [self handleWithType:LSProgressButtonBlockTypeCancel];
//    }
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancel];
    
}

+(void)showToView:(UIView *)view frame:(CGRect)frame success:(LSProgressButtonBlock)block
{
    LSProgressButton *button= [[self alloc]initWithFrame:frame];
    button.block=block;
    [view addSubview:button];
}

-(void)handleWithType:(LSProgressButtonBlockType)type
{
    if (self.block) {
        self.block(type);
    }
}

-(void)dealloc
{
    
    [LSNotificationCenter removeObserver:self];
    [self.timer invalidate];
    self.timer=nil;
}



@end
