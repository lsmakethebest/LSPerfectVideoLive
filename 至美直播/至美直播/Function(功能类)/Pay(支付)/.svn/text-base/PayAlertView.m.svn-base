

//
//  PayAlertView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "PayAlertView.h"
#import "TipPlainCell.h"
@interface PayAlertView ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic,strong) NSArray *contents;

@end

@implementation PayAlertView
+ (void)showPayAlertViewWithBlock:(BlockIndex)clickBlock
{
    
    PayAlertView *view = [[PayAlertView alloc] init];
    view.clickBlock=clickBlock;
    
    UIView *window = [[[UIApplication sharedApplication] windows] lastObject];
    
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]
                                     initWithTarget:view
                                     action:@selector(dismiss)];
        tap.delegate=view;
      [view addGestureRecognizer:tap];
    
    view.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.204];
    view.frame = window.bounds;
    view.contents=@[@"余额支付",@"支付宝支付",@"线下支付"];
    [window addSubview:view];
    
    UITableView *tableView =
    [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                 style:UITableViewStylePlain];
    tableView.layer.cornerRadius=5;
    tableView.layer.masksToBounds=YES;
    tableView.width = view.width * 3 / 5;
    tableView.height = view.contents.count * 44;
    tableView.center = view.center;
    tableView.delegate = view;
    tableView.dataSource = view;
    view.tableView = tableView;
    [view addSubview:tableView];
    
    view.alpha = 0;
    tableView.alpha = 0;
    [UIView animateWithDuration:0.25
                     animations:^{
                         view.alpha = 1;
                         tableView.alpha = 1;
                     }];
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TipPlainCell *cell =
    [TipPlainCell tipPlainCellWithTableView:tableView];
    cell.textLabel.text = self.contents[indexPath.row];
    return cell;
}
#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.alpha=0;
    if (self.clickBlock) {
        self.clickBlock(indexPath.row);
        [self removeFromSuperview];
    }
    
}
-(void)dealloc
{
    DLog(@"%s",__func__);
}
/// 消失
-(void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        
    }];
}
@end
