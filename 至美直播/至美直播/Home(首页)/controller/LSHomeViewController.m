
//
//  LSHomeViewController.m
//  至美直播
//
//  Created by 刘松 on 16/8/5.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSHomeViewController.h"
#import "LSHotViewController.h"
#import "LSShortVideoViewController.h"


@interface LSHomeViewController ()

@property (nonatomic,strong) UIViewController *hot;

@property (nonatomic,strong) UIViewController *video;

@property (nonatomic,weak) UIButton *selectBtn;

@end

@implementation LSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationItem.title=NSLocalizedString(@"homeTitle", nil);
    
    
    
    CGFloat width=70;
    CGFloat height=35;
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, 2*width, height);
    //    view.backgroundColor=[UIColor whiteColor];
    
    UIButton *liveBtn=[self createButton:@"热门直播" view:view];
    liveBtn.tag=0;
    liveBtn.frame=CGRectMake(0, 0, width, height);
    liveBtn.selected=YES;
    self.selectBtn=liveBtn;
    
    UIButton *videoBtn=[self createButton:@"短视频" view:view];
    videoBtn.frame= CGRectMake(width, 0, width, height);
    videoBtn.tag=1;
    self.navigationItem.titleView=view;
    
    
    
    LSHotViewController *hot=[[LSHotViewController alloc]initWithStyle:UITableViewStyleGrouped];
    hot.nav=self.navigationController;
    
//    [self addChildViewController:hot];
    hot.view.frame=CGRectMake(0, 0, SCREEN_W, SCREEN_H-49);
    [self.view addSubview:hot.view];
    self.hot=hot;
    
    LSShortVideoViewController *video=[[LSShortVideoViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
//    [self addChildViewController:video];
    
        video.view.frame=self.view.bounds;
    video.view.frame=CGRectMake(0, 0, SCREEN_W, SCREEN_H-49);
    [self.view addSubview:video.view];
    video.view.hidden=YES;
    self.video=video;
    
    
}
-(UIButton*)createButton:(NSString*)title view:(UIView*)view
{
    UIButton *btn=    [[UIButton alloc]init];
    btn.titleLabel.font=[UIFont systemFontOfSize:16];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [view addSubview:btn];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:RGB(0xf24e91) forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}


-(void)click:(UIButton*)btn
{
    if (self.selectBtn==btn) {
        return;
    }
    
    self.selectBtn.selected=NO;
    btn.selected=YES;
    self.selectBtn=btn;
    

    self.hot.view.hidden=(btn.tag!=0);
    self.video.view.hidden=(btn.tag==0);
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    DLog(@"1111111111111=====%lf",self.view.height);
}




@end
