
//
//  UITableView+Empty.m
//  自定义tableview
//
//  Created by 刘松 on 16/5/20.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (ALinGif)
// 播放GIF
- (void)playGifAnim:(NSArray *)images
{
    if (!images.count) {
        return;
    }
    //动画图片数组
    self.animationImages = images;
    //执行一次完整动画所需的时长
    self.animationDuration = 0.5;
    //动画重复次数, 设置成0 就是无限循环
    self.animationRepeatCount = 0;
    [self startAnimating];
}
// 停止动画
- (void)stopGifAnim
{
    if (self.isAnimating) {
        [self stopAnimating];
    }
}
@end
