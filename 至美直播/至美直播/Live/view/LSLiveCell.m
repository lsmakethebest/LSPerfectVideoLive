//
//  LSLiveCell.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSLiveCell.h"
#import "LSLiveMaskView.h"

@interface LSLiveCell ()<UIGestureRecognizerDelegate>

@property(weak, nonatomic) IBOutlet LSLiveMaskView *maskView;
/** 直播播放器 */
@property(nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/** 直播开始前的占位图片 */
@property(nonatomic, strong) UIImageView *placeHolderView;

@property(weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;

@end

@implementation LSLiveCell
- (UIImageView *)placeHolderView {
  if (!_placeHolderView) {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = self.contentView.bounds;
    imageView.image = [UIImage imageNamed:@"profile_user_414x414"];
    [self.contentView insertSubview:imageView atIndex:0];
    _placeHolderView = imageView;
    //        [self.parentVc showGifLoding:nil inView:self.placeHolderView];
    // 强制布局
    //        [_placeHolderView layoutIfNeeded];
  }
  return _placeHolderView;
}
- (void)awakeFromNib {
  [super awakeFromNib];
  [self setupEvents];
   
}
- (void)setupEvents {
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(tapClick)];
//  [self.maskView addGestureRecognizer:tap];

  UIPanGestureRecognizer *pan =
      [[UIPanGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePan:)];
  [self addGestureRecognizer:pan];
    pan.delegate=self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}
- (void)setModel:(LSUserModel *)model {
  _model = model;
  [self plarFLV:model.flv placeHolderUrl:model.bigpic];
    self.maskView.model=model;
}
#pragma mark - private method

- (void)plarFLV:(NSString *)flv placeHolderUrl:(NSString *)placeHolderUrl {
  if (_moviePlayer) {
    if (_moviePlayer) {
      [self.contentView insertSubview:self.placeHolderView
                         aboveSubview:_moviePlayer.view];
    }
    //        if (_catEarView) {
    //            [_catEarView removeFromSuperview];
    //            _catEarView = nil;
    //        }
    [_moviePlayer shutdown];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  }

  //    // 如果切换主播, 取消之前的动画
  //    if (_emitterLayer) {
  //        [_emitterLayer removeFromSuperlayer];
  //        _emitterLayer = nil;
  //    }
  //
  [[SDWebImageDownloader sharedDownloader]
      downloadImageWithURL:[NSURL URLWithString:placeHolderUrl]
                   options:SDWebImageDownloaderUseNSURLCache
                  progress:nil
                 completed:^(UIImage *image, NSData *data, NSError *error,
                             BOOL finished) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                     //            [self.parentVc showGifLoding:nil
                     //            inView:self.placeHolderView];
                     self.placeHolderView.image =
                         [UIImage blurImage:image blur:0.8];
                   });
                 }];

  IJKFFOptions *options = [IJKFFOptions optionsByDefault];
  [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];

  // 帧速率(fps)
  // （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
  [options setPlayerOptionIntValue:29.97 forKey:@"r"];
  // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
  [options setPlayerOptionIntValue:512 forKey:@"vol"];
  IJKFFMoviePlayerController *moviePlayer =
      [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv
                                                       withOptions:options];
  moviePlayer.view.frame =
      CGRectMake(0, 0, SCREEN_W, SCREEN_H); // self.contentView.bounds;

  // 填充fill
  moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
  // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
  moviePlayer.shouldAutoplay = NO;
  // 默认不显示
  moviePlayer.shouldShowHudView = NO;
  [self.contentView insertSubview:moviePlayer.view belowSubview:self.maskView];
    
  [moviePlayer prepareToPlay];

  self.moviePlayer = moviePlayer;

  // 设置监听
  [self initObserver];

  // 显示工会其他主播和类似主播
  //    [moviePlayer.view bringSubviewToFront:self.otherView];

  // 开始来访动画
  //    [self.emitterLayer setHidden:NO];
}
- (void)initObserver {
  // 监听视频是否播放完成
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(didFinish)
             name:IJKMPMoviePlayerPlaybackDidFinishNotification
           object:self.moviePlayer];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(stateDidChange)
             name:IJKMPMoviePlayerLoadStateDidChangeNotification
           object:self.moviePlayer];
}
#pragma mark - notify method

- (void)stateDidChange {
  if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
    if (!self.moviePlayer.isPlaying) {
      [self.moviePlayer play];
      [_placeHolderView removeFromSuperview];
      _placeHolderView = nil;
      dispatch_after(
          dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
          dispatch_get_main_queue(), ^{
            if (_placeHolderView) {
              //                    [self.moviePlayer.view
              //                    addSubview:_renderer.view];
            }
            //                [self.parentVc hideGufLoding];
          });
    } else {
      //            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
      //            if (self.parentVc.gifView.isAnimating) {
      //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
      //                (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(),
      //                ^{
      //                    [self.parentVc hideGufLoding];
      //                });
      //
      //            }
    }
  } else if (self.moviePlayer.loadState &
             IJKMPMovieLoadStateStalled) { // 网速不佳, 自动暂停状态
    //        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
  }
}

- (void)didFinish {
  NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState,
        self.moviePlayer.playbackState, __func__);
  // 因为网速或者其他原因导致直播stop了, 也要显示GIF
  //    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled &&
  //    !self.parentVc.gifView) {
  //        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
  //        return;
  //    }
  //    方法：
  //      1、重新获取直播地址，服务端控制是否有地址返回。
  //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
  __weak typeof(self) weakSelf = self;
  //    [[ALinNetworkTool shareTool] GET:self.live.flv parameters:nil
  //    progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id
  //    _Nullable responseObject) {
  //        NSLog(@"请求成功%@, 等待继续播放", responseObject);
  //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull
  //    error) {
  //        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
  //        [weakSelf.moviePlayer shutdown];
  //        [weakSelf.moviePlayer.view removeFromSuperview];
  //        weakSelf.moviePlayer = nil;
  //        weakSelf.endView.hidden = NO;
  //    }];
}
- (void)layoutSubviews {
  [super layoutSubviews];
  //    self.moviePlayer.view.frame=self.bounds;
  DLog(@"frame===%@", NSStringFromCGRect(self.contentView.bounds));
}
- (IBAction)close:(id)sender {
  if (_moviePlayer) {
    [self.moviePlayer shutdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  }
  [[self viewController] dismissViewControllerAnimated:YES completion:nil];
}



- (void)handlePan:(UIPanGestureRecognizer *)pan {
   
    static BOOL right=YES;
  CGFloat x = [pan translationInView:pan.view].x;
    CGFloat maxV=1000;
    NSLog(@"vvvvvvvv=%lf", [pan velocityInView:pan.view].x);
    CGFloat v=fabs([pan velocityInView:pan.view].x);
   
    
  

    switch (pan.state)
    {
      case UIGestureRecognizerStateBegan:
      {
        UITableViewController *vc= (UITableViewController*)[self viewController];
//          vc.tableView.scrollEnabled=NO;
//          if ([pan velocityInView:pan.view].x<-maxV) {
//              [UIView animateWithDuration:0.2 animations:^{
//                  self.leadingConstraint.constant =0;
//                  [self.maskView layoutIfNeeded];
//              }];
//              break
//              ;
//          }
//          if ([pan velocityInView:pan.view].x>maxV) {
//              [UIView animateWithDuration:0.2 animations:^{
//                  self.leadingConstraint.constant =SCREEN_W;
//                  [self.maskView layoutIfNeeded];
//              }];
//              break
//              ;
//          }
           right= [pan velocityInView:pan.view].x>0;

    break;
      }
  case UIGestureRecognizerStateChanged:
   
    if (self.leadingConstraint.constant + x <= 0) {
      break;
    }
    self.leadingConstraint.constant += x;
    break;
  case UIGestureRecognizerStateEnded:
  case UIGestureRecognizerStateCancelled: {
        DLog(@"v====%lf",v);
      UITableViewController *vc= (UITableViewController*)[self viewController];
//      vc.tableView.scrollEnabled=YES;
    CGFloat lastX = 0;
      
      if (right) {
          if (self.leadingConstraint.constant > SCREEN_W * 0.3||v>maxV) {
              lastX = SCREEN_W;
          } else {
              lastX = 0;
          }
      }else{
          if (self.leadingConstraint.constant < SCREEN_W * (1-0.3)||v>maxV) {
              lastX = 0;
          } else {
              lastX = SCREEN_W;
          }
      }
   
    self.leadingConstraint.constant = lastX;
    [UIView animateWithDuration:0.3
                     animations:^{
                       [self layoutIfNeeded];
                     }];
      
      
    break;
  }
  default:
    break;
  }
  
    [pan setTranslation:CGPointMake(0, 0) inView:pan.view];
}





- (void)tapClick {
  [self animateInView:self.maskView];
}
- (void)animateInView:(UIView *)view
{
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.frame = CGRectMake(view.width - 50, view.height - 50-15, 30, 30);
  int nameI = arc4random() % 9 + 1;
  imageView.image =
      [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30_", nameI]];
  [view addSubview:imageView];

  // Pre-Animation setup
  imageView.transform = CGAffineTransformMakeScale(0, 0);
  imageView.alpha = 0;

  //在底部 由无到有 又小变大的弹性动画
  [UIView animateWithDuration:0.3
                        delay:0.0
       usingSpringWithDamping:0.6
        initialSpringVelocity:0.8
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     imageView.transform = CGAffineTransformIdentity;
                     //                       imageView.transform =
                     //                       CGAffineTransformScale(imageView.transform,
                     //                       4, 4);
                     imageView.alpha = 0.9;
                   }
                   completion:NULL];

  NSInteger i = arc4random_uniform(2);
  NSInteger rotationDirection = 1 - (2 * i); // -1 OR 1
  NSInteger rotationFraction = arc4random_uniform(10);

  NSTimeInterval totalAnimationDuration = 6;
  //放大后向左或向右旋转一定角度动画
  [UIView
      animateWithDuration:totalAnimationDuration
               animations:^{
                 imageView.transform = CGAffineTransformMakeRotation(
                     rotationDirection * M_PI / (16 + rotationFraction * 0.2));
               }
               completion:NULL];

  // S型动画

  CGFloat heartSize = CGRectGetWidth(imageView.bounds);
  CGFloat heartCenterX = imageView.center.x;
  CGFloat viewHeight = CGRectGetHeight(view.bounds);

  UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
  [heartTravelPath moveToPoint:imageView.center];

  // 随机结束点
  CGPoint endPoint = CGPointMake(
      heartCenterX + (rotationDirection)*arc4random_uniform(2 * heartSize),
      viewHeight / 6.0 + arc4random_uniform(viewHeight / 4.0));

  NSInteger j = arc4random_uniform(2);
  NSInteger travelDirection = 1 - (2 * j); // -1 OR 1

  //绘制S型曲线 随机点
  CGFloat xDelta =
      (heartSize / 2.0 + arc4random_uniform(2 * heartSize)) * travelDirection;
  CGFloat yDelta =
      MAX(endPoint.y, MAX(arc4random_uniform(8 * heartSize), heartSize));

  //控制点1 控制点2
  CGPoint controlPoint1 = CGPointMake(heartCenterX + xDelta, yDelta);
  CGPoint controlPoint2 = CGPointMake(heartCenterX - xDelta, yDelta);
  //    CGPoint controlPoint1 =
  //    CGPointMake(heartCenterX + xDelta, viewHeight - yDelta);
  //    CGPoint controlPoint2 = CGPointMake(heartCenterX - 2 * xDelta, yDelta);

  [heartTravelPath addCurveToPoint:endPoint
                     controlPoint1:controlPoint1
                     controlPoint2:controlPoint2];

  CAKeyframeAnimation *keyFrameAnimation =
      [CAKeyframeAnimation animationWithKeyPath:@"position"];
  keyFrameAnimation.path = heartTravelPath.CGPath;
  keyFrameAnimation.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  keyFrameAnimation.duration = totalAnimationDuration + endPoint.y / viewHeight;

        [imageView.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];

  // 动画消失
  [UIView animateWithDuration:totalAnimationDuration
      animations:^{
        imageView.alpha = 0.0;
      }
      completion:^(BOOL finished) {
        [imageView removeFromSuperview];
      }];
}
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
////    NSLog(@"--------------------------------------------------------");
//    if ([NSStringFromClass(gestureRecognizer.view.class) isEqualToString:@"UITableViewCellContentView"]&&([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"LSLiveCell"]||[NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"UITableViewWrapperView"])) {
//        return  YES;
//        
//    }
//    if ([NSStringFromClass(gestureRecognizer.view.class) isEqualToString:@"LSLiveCell"]&&([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UITableView"]||[NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"UITableViewWrapperView"])) {
//        return  YES;
//        
//    }
//    NSLog(@"view=%@=view===%@",gestureRecognizer.view.class ,otherGestureRecognizer.view.class);
//    return NO;
//}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
@end
