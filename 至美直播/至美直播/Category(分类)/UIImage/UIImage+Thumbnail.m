

//
//  UIImage+Thumbnail.m
//  至美微博
//
//  Created by song on 15/10/10.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "UIImage+Thumbnail.h"

@implementation UIImage (Thumbnail)
//自动缩放到指定大小

+ (UIImage *)thumbnailWithImage:(UIImage *)image
                           size:(CGSize)asize

{

  UIImage *newimage;

  if (nil == image) {
    newimage = nil;
  } else {
    UIGraphicsBeginImageContext(asize);
    [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  return newimage;
}

//保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image
                                       size:(CGSize)asize {
  UIImage *newimage;
  if (nil == image) {
    newimage = nil;
  } else {
    CGSize oldsize = image.size;
    CGRect rect;
    if (asize.width / asize.height > oldsize.width / oldsize.height) {
      rect.size.width = asize.height * oldsize.width / oldsize.height;
      rect.size.height = asize.height;
      rect.origin.x = (asize.width - rect.size.width) / 2;
      rect.origin.y = 0;
    } else {
      rect.size.width = asize.width;
      rect.size.height = asize.width * oldsize.height / oldsize.width;
      rect.origin.x = 0;
      rect.origin.y = (asize.height - rect.size.height) / 2;
    }
    UIGraphicsBeginImageContext(asize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, asize.width, asize.height)); // clear background
    [image drawInRect:rect];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  return newimage;
}
@end
