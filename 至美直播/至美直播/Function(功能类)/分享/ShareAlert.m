

//
//  ShareAlert.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/3.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "ShareAlert.h"
#import "KCCoverView.h"

//#import "KCFindButton.h"
#import "UMShare.h"

//#import "KCInviteButton.h"

@interface ShareAlert ()

//@property(nonatomic,strong)   KCGoodsModel *model;
@end
@implementation ShareAlert


//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.frame=CGRectMake(0, 0, SCREEN_W, 150);
//        self.backgroundColor=[UIColor whiteColor];
//    }
//    return self;
//}
//
//-(void)show
//{
//    UILabel *label=[[UILabel alloc]init];
//    label.textAlignment=NSTextAlignmentCenter;
//    label.text=@"分享到";
//    label.font=KCFont5;
//    label.textColor=KCColor2;
//    label.frame=CGRectMake(0, 10, SCREEN_W, 25);
//    [self addSubview:label];
//    
//    
//    CGFloat width = (SCREEN_W - 15 * 2) / 4;
//    CGFloat height = 80;
//    
//    NSMutableArray *arr = [NSMutableArray array];
//    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
//        [arr addObject:@"微信"];
//    }
//    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
//        [arr addObject:@"朋友圈"];
//    }
//    
//    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
//        [arr addObject:@"QQ"];
//    }
//    [arr addObject:@"链接"];
//    
//    for (int i = 0; i < arr.count; i++) {
//        KCInviteButton *btn = [[KCInviteButton alloc] init];
//        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
//        btn.frame = CGRectMake(15 + width * i, MaxY(label)+18, width, height);
//        
//        NSString *name = arr[i];
//        NSString *imageName;
//        int tag = 0;
//        if ([name isEqualToString:@"微信"]) {
//            tag = 0;
//            imageName = @"weixin";
//        }
//        else if([name isEqualToString:@"朋友圈"]){
//            imageName = @"朋友圈";
//            tag = 1;
//        }
//        else if ([name isEqualToString:@"QQ"]) {
//            imageName = @"qq";
//            tag = 2;
//        }
//        else {
//            imageName = @"链接";
//            tag = 3;
//        }
//        [btn setTitle:name forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        btn.tag = tag;
//        [self addSubview:btn];
//    }
//
//}
//+(instancetype)showWithModel:(KCGoodsModel *)model vc:(UIViewController *)vc
//{
//
//    ShareAlert *alert= [[self alloc]init];
//    alert.model=model;
//    alert.vc=vc;
//    [alert show];
//    return alert;
//    
//}
//-(void)share:(UIButton*)sender
//{
//
//    KCCoverView *cover=self.superview;
//    [cover dismiss];
//    
//    UIViewController *vc=self.vc;
//    NSString *url= StringFormat(BaseShare_URL, self.model.id);
//    NSString *content=[NSString stringWithFormat:@"%@-%@ %@ %@ %@至%@",self.model.deliverCityName,self.model.takeCityName,self.model.goodsTypeName,self.model.vehicleTypeName,self.model.startTime.ymdLineString,self.model.endTime.ymdLineString];
//    
//    NSString *title=@"快成司机-货源信息";
//    if (sender.tag == 0) {
//        [UMShare shareWithType:UMSocialPlatformType_WechatSession
//                         title:title
//                      shareURL:url
//                    shareImage:nil
//                     shareText:content
//                viewController:vc];
//    } else if (sender.tag == 1) {
//        [UMShare shareWithType:UMSocialPlatformType_WechatTimeLine
//                         title:title
//                      shareURL:url
//                    shareImage:nil
//                     shareText:content
//                viewController:vc];
//    } else if(sender.tag==2){
//        [UMShare shareWithType:UMSocialPlatformType_QQ
//                         title:title
//                      shareURL:url
//                    shareImage:nil
//                     shareText:content          viewController:vc];
//    }else{
//        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//        pboard.string = url;
//        [UIToast showMessage:@"复制成功"];
//    }
//
//    
//}
  -(void)dealloc
{
    
    
    
}
@end
