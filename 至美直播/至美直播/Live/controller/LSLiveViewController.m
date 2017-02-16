
//
//  LSLiveViewController.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSLiveViewController.h"
#import "LSLiveCell.h"
@interface LSLiveViewController ()

@end

@implementation LSLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"LSLiveCell" bundle:nil] forCellReuseIdentifier:@"LSLiveCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickBottom:) name:LSClickBottomButtonNotification object:nil];
   LSRefreshGifHeader *header= [LSRefreshGifHeader headerWithRefreshingTarget:self  refreshingAction:@selector(previous)];
    self.tableView.mj_header =header;
    
    [header setTitle:@"下拉切换上一个主播" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉切换上一个主播" forState:MJRefreshStatePulling];
    [header setTitle:@"切换中" forState:MJRefreshStateRefreshing];
    
    MJRefreshBackGifFooter *footer=[MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(next)];
    [footer setTitle:@"上拉切换下一个主播" forState:MJRefreshStateIdle];
    [footer setTitle:@"上拉切换下一个主播" forState:MJRefreshStatePulling];
    [footer setTitle:@"切换中" forState:MJRefreshStateRefreshing];
    NSArray *images= @[[UIImage imageNamed:@"reflesh1_60x55_"],[UIImage imageNamed:@"reflesh2_60x55_"],[UIImage imageNamed:@"reflesh3_60x55_"]];
    [footer setImages:@[[UIImage imageNamed:@"reflesh1_60x55_"]] forState:MJRefreshStateIdle];
    [footer setImages:@[[UIImage imageNamed:@"reflesh1_60x55_"]] forState:MJRefreshStatePulling];
    [footer setImages:images forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer=footer;
    
}
-(void)next
{
    self.currentIndex++;
    if (self.currentIndex==self.datas.count) {
        self.currentIndex=0;
    }
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}
-(void)previous
{
    [self.tableView.mj_header endRefreshing];
    self.currentIndex--;
    if (self.currentIndex==-1) {
        self.currentIndex=self.datas.count-1;
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.datas.count) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSLiveCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LSLiveCell"];
    cell.model=self.datas[self.currentIndex];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_H;
}


- (void) viewWillAppear: (BOOL)animated {
    [IQKeyboardManager sharedManager].enable = NO;
    [[IQKeyboardManager sharedManager]disableToolbarInViewControllerClass:[self class]];
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder=NO;
    
}

- (void) viewWillDisappear: (BOOL)animated {
    [IQKeyboardManager sharedManager].enable = YES;
    
}

-(void)clickBottom:(NSNotification*)note
{

    int tag=[note.object intValue];
    switch (tag) {
        case 0:
            
            break;
        
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}
@end
