

//
//  PublicAlertView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/4.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "PublicAlertView.h"
#import "TipPlainCell.h"

@interface PublicAlertView ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic,strong) NSArray *contents;

@end

@implementation PublicAlertView
+ (void)showPayAlertViewWithArray:(NSArray*)array block:(BlockIndex)clickBlock
{
    
    PublicAlertView *view = [[PublicAlertView alloc] init];
    view.clickBlock=clickBlock;
    
    UIView *window = [[[UIApplication sharedApplication] windows] lastObject];
    
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]
                                     initWithTarget:view
                                     action:@selector(dismiss)];
        tap.delegate=view;
      [view addGestureRecognizer:tap];
    
    view.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.204];
    view.frame = window.bounds;
    view.contents=array;
    [window addSubview:view];
    
    UITableView *tableView =
    [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                 style:UITableViewStylePlain];
    tableView.layer.cornerRadius=5;
    tableView.layer.masksToBounds=YES;
    tableView.width = view.width * 3 / 5;
    tableView.height = view.contents.count * 44;
    if (view.contents.count>8) {
    tableView.height = 8 * 44;
    }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.alpha=0;
    if (self.clickBlock) {
        self.clickBlock((int)indexPath.row);
        [self dismiss];
    }
    
}
/// 消失
-(void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        
    }];
}
#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
-(void)dealloc
{
    
}

@end
