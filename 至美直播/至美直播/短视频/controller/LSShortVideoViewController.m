




//
//  LSShortVideoViewController.m
//  至美直播
//
//  Created by 刘松 on 2017/1/18.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSShortVideoViewController.h"

#import "LSShortVideoCell.h"

#import "LSPlayerView.h"

#import "LSShortVideoModel.h"



@interface LSShortVideoViewController ()

@property(nonatomic,strong) NSMutableArray *datas;
@end

@implementation LSShortVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //sfdjlsjlklsjl
    
    self.tableView.mj_header =
    [LSRefreshGifHeader headerWithRefreshingTarget:self
                                  refreshingAction:@selector(startRefresh)];
    
    self.tableView.startTip = YES;
    self.tableView.tipTitle = @"暂无短视频";
    self.tableView.startRetryButton = YES;
    self.tableView.startLoading = NO;
    self.tableView.loadingImages = @[
                                     [UIImage imageNamed:@"hold1_60x72_"],
                                     [UIImage imageNamed:@"hold2_60x72_"],
                                     [UIImage imageNamed:@"hold3_60x72_"]
                                     ];
    [self.tableView registerNib:[UINib nibWithNibName:@"LSShortVideoCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"LSShortVideoCell"];
    
    [self.tableView.mj_header beginRefreshing];
}
-(void)startRefresh
{
    [LSHttpManager POST:LSGetShortVideoURL parameters:nil success:^(NSDictionary *response) {
        [self.tableView.mj_header endRefreshing];
        
        self.datas= [LSShortVideoModel mj_objectArrayWithKeyValuesArray:response[@"result"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return  self.datas.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LSShortVideoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LSShortVideoCell"];
    
    LSShortVideoModel *model =self.datas[indexPath.section];
    cell.model=model;
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 263;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    LSPlayerView* playerView = [LSPlayerView playerView];
    playerView.index=indexPath.section;
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    playerView.currentFrame=cell.frame;
    
    //必须先设置tempSuperView在设置videoURL
    playerView.tempSuperView=self.tableView;
    LSShortVideoModel *model =self.datas[indexPath.section];
    playerView.videoURL=StringFormat(LSQNFileHost,model.videokey );

}



//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"%lf------%lf",self.tableView.contentOffset.y,self.tableView.contentInset.bottom);
//}




@end
