

//
//  NavigationController.m
//  至美直播
//
//  Created by 刘松 on 16/8/5.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()


@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate=self;
    UINavigationBar *navBar=[UINavigationBar appearance];
    [navBar setBackgroundImage:[KCColor1 imageWithColor] forBarMetrics:(UIBarMetricsDefault)];
    NSDictionary *dict=[NSDictionary dictionaryWithObject: [UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [navBar setTitleTextAttributes:dict];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setShadowImage:[[UIImage alloc]init]];
    
    
    
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:KCFont5,NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_9x16"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBack)];
    }
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [super pushViewController:viewController animated:animated];
}
-(void)clickBack
{
    [self popViewControllerAnimated:YES];
}
@end
