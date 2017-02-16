//
//  UITableView+Empty.h
//  自定义tableview
//
//  Created by 刘松 on 16/5/20.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^RetryBlock)();
@interface UITableView (LSEmpty)

//开启无内容提示
@property (nonatomic,assign) BOOL startTip;
//无cell提示语
@property (nonatomic,copy) NSString *tipTitle;
//无cell提示图片
@property(nonatomic,strong) UIImage *tipImage;
//无网时的图片
@property(nonatomic,strong) UIImage *badNetworkImage;


/*开启无网重新尝试按钮  如果是无网就设置badNetwork =YES 每次reloadData时内部都会设置成NO所以不必手动设置为NO*/

//开启点击重新尝试按钮
@property (nonatomic,assign) BOOL startRetryButton;
//是否无网或网络差 需手动设置 一般为第一次加载数据时 数据并且为空设置为YES 
@property (nonatomic,assign) BOOL badNetwork;

//点击重试按钮的block
@property (nonatomic,copy) RetryBlock retryBlock;



//开启第一次加载动画 如果开启此动画在无网重试按钮点击时也会加载动画
@property (nonatomic,assign) BOOL startLoading;
/**
 *如果开启了无网重试按钮 则在无网时设置badNetwork时或reloadta时会自动取消loading
 */
-(void)hideLoading;
//加载图片动画数组
@property(nonatomic,strong) NSArray *loadingImages;
//加载文字
@property (nonatomic,copy) NSString *loadingTitle;




/*****************************私有属性 请勿使用****************************/
 //存放所有的控件
@property(nonatomic, weak) UIView *tipView;
//无cell提示语label
@property(nonatomic, weak) UILabel *tipLabel;
 //无cell提示imageView
@property(nonatomic, weak) UIImageView *tipImageView;
 ////无网重试提示语
@property (nonatomic,weak) UILabel *badNetworkLabel;
//无网重试按钮
@property (nonatomic,weak) UIButton *retryButton;


@property (nonatomic,weak) UIImageView *loadingImageView;
@property (nonatomic,weak) UILabel *loadingLabel;

@property (nonatomic,assign) BOOL isFirstReloadData;
@property (nonatomic,assign) CGFloat ls_topHeight;//为了解决MJRefresh刷新带来的contentInsetY变化带来的bug 存储正常contentInsetY


@end
