


//
//  WebViewController.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/2.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic,weak) UIButton *retryBttn;
@property (nonatomic,weak) UIWebView *webView;
@property (nonatomic,assign) BOOL load;

@end
@implementation WebViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"网页浏览";
    if (self.currentTitle) {
        self.title=self.currentTitle;
    }
    UIWebView *webView=[[UIWebView alloc]init];
    webView.frame=self.view.bounds;
    webView.height=SCREEN_H-64;
    [self.view addSubview:webView];
    webView.delegate=self;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [webView loadRequest:request];
    self.webView=webView;

    
    UIButton *btn=[[UIButton alloc]init];
    btn.frame=CGRectMake(0, 0, 100, 40);
    [btn setTitle:@"点击重新加载" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.611] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
     btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.center=self.view.center;
    btn.hidden=YES;
    [self.view addSubview:btn];
    self.retryBttn=btn;
    
    [btn addTarget:self action:@selector(retryRequest) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.load==NO) {
        [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
        self.load=YES;
    }

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webView.hidden=NO;
    [MBProgressHUD hideHUDForView:self.view];
}
#pragma mark - 重新加载
-(void)retryRequest
{
    self.load=NO;
    self.retryBttn.hidden=YES;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    [self.webView loadRequest:request];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view];
    self.webView.hidden=YES;
    self.retryBttn.hidden=NO;
}
@end
