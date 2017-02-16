

//
//  LSContentController.m
//  LSScrollPage
//
//  Created by ls on 15/12/28.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSContentController.h"
@interface LSContentController ()

@end
@implementation LSContentController

- (void)setData:(LSModel *)model
    needRefresh:(BOOL)needRefresh
      scrollTop:(BOOL)scrollTop
contentOffset_Y:(CGFloat)contentOffset_Y {
  [self.tableView setContentOffset:CGPointMake(0, contentOffset_Y)];
  if (scrollTop) {
      if (self.tableView.contentOffset.y!=0) {
          [self.tableView
           scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
           atScrollPosition:UITableViewScrollPositionTop
           animated:YES];
      }
    return;
  }
  if (needRefresh) { //滑动结束
    self.model = model;
      switch (self.model.footerState) {
          case LSFooterStateHidden:
              self.tableView.mj_footer.hidden=YES;
              break;
              
          case LSFooterStateNormal:
              self.tableView.mj_footer.hidden=NO;
              self.tableView.mj_footer.state=MJRefreshStateIdle;
              break;
          case LSFooterStateNoMoreData:
              self.tableView.mj_footer.hidden=NO;
              self.tableView.mj_footer.state=MJRefreshStateNoMoreData;
              break;
          default:
              break;
      }
    [self.tableView reloadData];
      if (self.model.dataList.count<=0) {
          //请求更多数据
          [self refreshData];
      }

  } else { //只是滑动过程中设置数据并不会加载新数据
    self.model = model;
      switch (self.model.footerState) {
          case LSFooterStateHidden:
              self.tableView.mj_footer.hidden=YES;
              break;
              
          case LSFooterStateNormal:
              self.tableView.mj_footer.hidden=NO;
              self.tableView.mj_footer.state=MJRefreshStateIdle;
              break;
          case LSFooterStateNoMoreData:
              self.tableView.mj_footer.hidden=NO;
              self.tableView.mj_footer.state=MJRefreshStateNoMoreData;
              break;
          default:
              break;
      }
    [self.tableView reloadData];
  }
}




@end
