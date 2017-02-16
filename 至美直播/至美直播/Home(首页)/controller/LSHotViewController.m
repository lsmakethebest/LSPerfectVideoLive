

//
//  LSHotViewController.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSHotTableViewCell.h"
#import "LSHotViewController.h"
#import "LSLiveViewController.h"
#import "LSUserModel.h"
#import "UIViewController+LSExtension.h"
@interface LSHotViewController ()

@property(nonatomic, assign) int currentPage;
@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, assign) int counts;
@property (nonatomic,assign) CGFloat startY;


@end

@implementation LSHotViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
 
    
  self.datas = [NSMutableArray array];
    
    
  UIView *headerView = [[UIView alloc] init];
  headerView.frame = CGRectMake(0, 0, SCREEN_W, 120);
  headerView.backgroundColor = RandomColor;
  self.tableView.tableHeaderView = headerView;

  [self.tableView registerNib:[UINib nibWithNibName:@"LSHotTableViewCell"
                                             bundle:nil]
       forCellReuseIdentifier:@"LSHotTableViewCell"];

  self.tableView.mj_header =
      [LSRefreshGifHeader headerWithRefreshingTarget:self
                                    refreshingAction:@selector(startRefresh)];

  self.tableView.mj_footer =
      [LSRefreshAutoFooter footerWithRefreshingTarget:self
                                     refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
  self.tableView.startTip = YES;
  self.tableView.tipTitle = @"暂无热门直播";
  self.tableView.startRetryButton = YES;
//  self.tableView.startLoading = YES;
  self.tableView.loadingImages = @[
    [UIImage imageNamed:@"hold1_60x72_"],
    [UIImage imageNamed:@"hold2_60x72_"],
    [UIImage imageNamed:@"hold3_60x72_"]
  ];
    
    
//  self.tableView.loadingTitle = @"正在努力加载中...";
  WeakSelf;
  self.tableView.retryBlock = ^() {
    weakSelf.currentPage = 1;
    [weakSelf loadData];
  };

//    [self.tableView.mj_header beginRefreshing];
  self.currentPage = 1;
  [self loadData];
}
- (void)startRefresh {

  self.currentPage = 1;
  [self loadData];
}
- (void)loadData {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"page"] = @(self.currentPage);
    params[@"type"]=@"1";
  [HttpManager POSTWithURLString:@"http://live.9158.com/Room/GetHotLive_v2"
      parameters:params
      success:^(NSDictionary *response) {
        [self endRefresh];
        if ([response[@"code"] integerValue] == 100) {
          self.counts = [response[@"data"][@"counts"] intValue];
          if (self.currentPage == 1) {
            self.tableView.mj_footer.state = MJRefreshStateIdle;
            [self.datas removeAllObjects];
            NSArray *arr = [LSUserModel
                mj_objectArrayWithKeyValuesArray:response[@"data"][@"list"]];
            [self.datas addObjectsFromArray:arr];
            [self.tableView reloadData];
          } else {
            NSArray *arr = [LSUserModel
                mj_objectArrayWithKeyValuesArray:response[@"data"][@"list"]];
            if (arr.count == 0) {
              self.tableView.mj_footer.state = MJRefreshStateNoMoreData;

            } else {
              [self.datas addObjectsFromArray:arr];
              [self.tableView reloadData];
            }
          }
          if (self.currentPage == self.counts) {
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
          }
             self.tableView.mj_footer.hidden=self.counts==0;
        }

      }
      failure:^(NSError *error) {
        if (self.datas.count == 0) {
          self.tableView.badNetwork = YES;
        }
        [self endRefresh];
      }];
}
- (void)loadMoreData {
  self.currentPage++;
  [self loadData];
}
- (void)endRefresh {
  if (self.tableView.mj_header.isRefreshing) {
    [self.tableView.mj_header endRefreshing];
  }
  if (self.tableView.mj_footer.isRefreshing) {
    [self.tableView.mj_footer endRefreshing];
  }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  LSHotTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"LSHotTableViewCell"];
  LSUserModel *model = self.datas[indexPath.section];
  //    UIView *v=[[UIView alloc]init];
  //    v.backgroundColor=[UIColor redColor];
  //    cell.selectedBackgroundView=v;
  cell.model = model;
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 386;
}


- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  [tableView deselectRowAtIndexPath:indexPath animated:YES];

  LSLiveViewController *vc = [[LSLiveViewController alloc] init];
  vc.currentIndex = indexPath.section;
  vc.datas = self.datas;
  [self presentViewController:vc animated:YES completion:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    CGFloat y=scrollView.contentOffset.y;
//   CGFloat moveY= (y-self.startY);
//    if (moveY<=0) {
//        self.nav.navigationBar.y=20;
//        return;
//    }
//    self.nav.navigationBar.y=20-moveY;
//    self.nav.tabBarController.tabBar.y=(SCREEN_H-49)+moveY;
//    if (moveY>=64) {
//        self.nav.viewControllers.firstObject.view.y=moveY;
//        return;
//    }
//    
//    
//    NSLog(@"-----------%lf",moveY);
//    
////    self.nav.navigationBar.hidden=YES;
//    self.nav.viewControllers.firstObject.view.frame=self.nav.view.bounds;
    
    
    
    
}  

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startY=scrollView.contentOffset.y;
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.startY=0;
}

@end
