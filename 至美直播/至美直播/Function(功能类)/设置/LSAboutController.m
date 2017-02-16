


//
//  LSAboutController.m
//  彩票
//
//  Created by song on 15/9/15.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSAboutController.h"
@interface LSAboutController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LSAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    LSSettingArrowItem *item1=[[LSSettingArrowItem alloc]initWithTitle:@"评分支持" Icon:nil];
    item1.option=^{
        NSString *appid=@"725296055";
        NSString *str= [NSString  stringWithFormat:@"itms-apps://itunes.apple.com/cn.app/%@?mt=8",appid];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
        NSLog(@"sdfsdf");
    
    };
    LSSettingArrowItem *item2=[[LSSettingArrowItem alloc]initWithTitle:@"客户电话" Icon:nil];
    item2.option=^{
    
        self.webView=[[UIWebView alloc]initWithFrame:CGRectZero];
        NSURL *url=[NSURL URLWithString:@"tel://10086"];
        
        [self.webView loadRequest:[[NSURLRequest alloc]initWithURL:url]];
    };
    item2.subTitle=@"10086";
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
    [group.items addObject:item1];
    [group.items addObject:item2];
    [self.datas addObject:group];
    
    
    
}


@end
