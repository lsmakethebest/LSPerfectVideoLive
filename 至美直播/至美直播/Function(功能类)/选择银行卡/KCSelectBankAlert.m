//
//  KCSelectBankAlert.m
//  driver
//
//  Created by 刘松 on 16/7/8.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCSelectBankAlert.h"
#import "KCSelectBankAlertCell.h"

#import "KCSelectBankModel.h"

@interface KCSelectBankAlert ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *myView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) KCSelectBankAlertCompletedBankSelect completedBankSelect;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property(nonatomic,strong) NSMutableArray *data;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstrain;
@property (nonatomic,assign) CGFloat maxHeight;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation KCSelectBankAlert

- (IBAction)cancel:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLayout.constant=-226;
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
+(void)showWithArray:(NSArray*)array title:(NSString*)title index:(NSInteger)index completedBankSelect:(KCSelectBankAlertCompletedBankSelect)completedBankSelect
{
    if (array.count==0||array==nil) {
        return;
    }
    KCSelectBankAlert *alert= [[[NSBundle mainBundle]loadNibNamed:@"KCSelectBankAlert" owner:nil options:nil]lastObject];
    alert.titleLabel.text=title;
    UITapGestureRecognizer*tap= [[UITapGestureRecognizer alloc]initWithTarget:alert action:@selector(cancel:)];
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
    UIView *view= [UIApplication sharedApplication].keyWindow;
    alert.frame=view.bounds;
    [view addSubview:alert];
    if (array.count>4) {
        alert.heightConstrain.constant=226;
    }else{
        alert.heightConstrain.constant=array.count*44+50;
    }
    alert.bottomLayout.constant=-226;
    [alert layoutIfNeeded];
    alert.alpha=0;
    [UIView animateWithDuration:0.3 animations:^{
        alert.bottomLayout.constant=0;
        [alert layoutIfNeeded];
        [alert layoutIfNeeded];
        alert.alpha=1;
    }];
    [alert.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
    
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
        self.completedBankSelect(indexPath.row);
        [self performSelector:@selector(cancel:) withObject:nil afterDelay:0];
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
