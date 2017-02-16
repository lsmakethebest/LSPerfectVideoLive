
//
//  RightAlertView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/17.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "RightAlertView.h"

#import "TipPlainCell.h"
@interface RightAlertView ()

<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic,strong) NSArray *contents;

@property (nonatomic,weak) UIView *alerView;
@end


@implementation RightAlertView

+ (void)showPayAlertViewWithArray:(NSArray*)array point:(CGPoint)point size:(CGSize)size block:(BlockIndex)clickBlock
{
    
    RightAlertView *view = [[self alloc] init];
    view.clickBlock=clickBlock;
    
    UIView *window = [[[UIApplication sharedApplication] windows] lastObject];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]
                                 initWithTarget:view
                                 action:@selector(dismiss)];
    tap.delegate=view;
    [view addGestureRecognizer:tap];
    
    view.backgroundColor = [UIColor clearColor];
    view.frame = window.bounds;
    view.contents=array;
    [window addSubview:view];
    
    
    UIView *alert=[[UIView alloc]init];
    [view addSubview:alert];
    view.alerView=alert;
    alert.layer.shadowColor=[UIColor blackColor].CGColor;
    alert.layer.shadowOffset=CGSizeMake(1, 1);
    alert.layer.shadowOpacity=0.5;
    alert.layer.shadowRadius=3;
    
    
    alert.width = 100;
    alert.height = view.contents.count * 44;
    alert.x=point.x-100+size.width-20;
    alert.y=point.y+size.height+2;
    if (view.contents.count>8) {
        alert.height = 8 * 44;
    }
    UITableView *tableView =
    [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                 style:UITableViewStylePlain];
    tableView.frame=alert.bounds;
    tableView.layer.cornerRadius=5;
    tableView.delegate = view;
    tableView.dataSource = view;
    tableView.backgroundColor=[UIColor colorWithRed:0.944 green:0.937 blue:0.937 alpha:1.000];
    view.tableView = tableView;
    [alert addSubview:tableView];
    
    view.alpha = 0;
    alert.alpha = 0;
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         view.alpha = 1;
                         alert.alpha = 1;
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
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
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

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
