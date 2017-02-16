


//
//  KCSelectCommonCity.m
//  driver
//
//  Created by 刘松 on 16/10/9.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCSelectCommonCity.h"

#import "KCSelectBankAlertCell.h"

#import "KCSelectBankModel.h"

@interface KCSelectCommonCity ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *myView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) KCSelectCommonCityCompletedBankSelect completedBankSelect;


@property(nonatomic,strong) NSMutableArray *data;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstrain;
@property (nonatomic,assign) CGFloat maxHeight;


@end

@implementation KCSelectCommonCity

- (IBAction)cancel {
    [UIView animateWithDuration:0.2 animations:^{
        self.heightConstrain.constant=0;
        [self layoutIfNeeded];
        self.alpha=0.5;

    }completion:^(BOOL finished) {
            [self removeFromSuperview];
    }];
    
}
-(void)click
{
    if (self.completedBankSelect) {
        self.completedBankSelect(0,NO);
        [self performSelector:@selector(cancel) withObject:nil afterDelay:0];
    }

}
+(instancetype)showWithArray:(NSArray*)array index:(NSInteger)index view:(UIView *)view frame:(CGRect)frame completedBankSelect:(KCSelectCommonCityCompletedBankSelect)completedBankSelect
{
    if (array.count==0||array==nil) {
        return nil;
    }
    KCSelectCommonCity *alert= [[[NSBundle mainBundle]loadNibNamed:@"KCSelectCommonCity" owner:nil options:nil]lastObject];

    UITapGestureRecognizer*tap= [[UITapGestureRecognizer alloc]initWithTarget:alert action:@selector(click)];
    tap.delegate=alert;
    [alert addGestureRecognizer:tap];
    alert.completedBankSelect=completedBankSelect;
    for (int i=0; i<array.count; i++) {
        KCSelectBankModel *model=[[KCSelectBankModel alloc]init];
        model.bank=array[i];
        if (i==index) {
            model.selected=YES;
        }else{
            model.selected=NO;
        }
        [alert.data addObject:model];
    }
    alert.frame=frame;
    [view addSubview:alert];
    CGFloat height;
//    if (array.count>4) {
//        height=176;
//    }else{
        height=array.count*44;
//    }
    
    alert.heightConstrain.constant=0;
    [alert layoutIfNeeded];
    alert.alpha=0;
    [UIView animateWithDuration:0.3 animations:^{
        alert.heightConstrain.constant=height;
        [alert layoutIfNeeded];
        alert.alpha=1;
    }];
    [alert.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
    return alert;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"KCSelectBankAlertCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.data=[NSMutableArray array];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KCSelectBankAlertCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model=self.data[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (int i=0; i<self.data.count; i++) {
        KCSelectBankModel *model=self.data[i];
        model.selected=NO;
        if (i==indexPath.row) {
            model.selected=YES;
        }
    }
    [self.tableView reloadData];
    if (self.completedBankSelect) {
        self.completedBankSelect(indexPath.row,YES);
        [self performSelector:@selector(cancel) withObject:nil afterDelay:0];
    }
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

#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

@end
