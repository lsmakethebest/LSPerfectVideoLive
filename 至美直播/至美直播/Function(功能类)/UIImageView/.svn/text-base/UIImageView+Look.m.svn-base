
//
//  UIImageView+Look.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/6/6.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "UIImageView+Look.h"

#import <objc/runtime.h>

@implementation UIImageView (Look)


-(void)setupViews
{
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(bigPicture)];
//    [self addGestureRecognizer:tap];
    
}
-(void)setStartLook:(BOOL)startLook
{
    if (startLook) {
//        if (self.tipView==nil) {
            [self setupViews];
//        }
    }
    objc_setAssociatedObject(self, @selector(startLook), @(startLook),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)startLook
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setObjectKey:(NSString *)objectKey
{
    objc_setAssociatedObject(self, @selector(objectKey), objectKey,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString *)objectKey
{
return objc_getAssociatedObject(self, _cmd) ;
}
-(void)bigPicture
{
    
//    UIImageView *imageView=[[UIImageView alloc]init];
//    imageView.frame=[UIScreen mainScreen].bounds;
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    [[UIApplication sharedApplication].keyWindow addSubview:imageView];
//    
//    params[@"objKey"]=self.objectKey;;
//        [HttpManager POSTWithURLString:KCLookBigPic_URL parameters:params success:^(NSDictionary *response) {
//            imageView setImageWithURL:[NSURL URLWithString:ob]
//            
//        } failure:^(NSError *error) {
//            
//        }];
    
    
}
@end
