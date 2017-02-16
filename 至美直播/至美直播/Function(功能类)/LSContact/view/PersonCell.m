//
//  PersonCell.m
//  BM
//
//  Created by yuhuajun on 15/7/13.
//  Copyright (c) 2015年 yuhuajun. All rights reserved.
//

#import "PersonCell.h"
#import "CDFInitialsAvatar.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


#define RGB1  RGB(48, 94, 136)
#define RGB2  RGB(45, 164, 147)
#define RGB3  RGB(50, 167, 230)
#define RGB4  RGB(47, 120, 162)
#define RGB5  RGB(71, 94, 149)
#define RGB6  RGB(186, 83, 189)
#define RGB7  RGB(100, 150, 75)
#define RGB8  RGB(69, 229, 195)


@implementation PersonCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
//        self.backgroundColor=[UIColor whiteColor];;
        
        _tximg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 40,40)];
        [self.contentView addSubview:_tximg];
        
        CDFInitialsAvatar *topAvatar = [[CDFInitialsAvatar alloc] initWithRect:_tximg.bounds fullName:@"测试"];
        topAvatar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tx_five"]];
        topAvatar.initialsFont=[UIFont fontWithName:@"STHeitiTC-Light" size:14];
        CALayer *mask = [CALayer layer]; // this will become a mask for UIImageView
        UIImage *maskImage = [UIImage imageNamed:@"AvatarMask"]; // circle, in this case
        mask.contents = (id)[maskImage CGImage];
        mask.frame = _tximg.bounds;
        _tximg.layer.mask = mask;
        //_tximg.layer.cornerRadius = YES;
        _tximg.image = topAvatar.imageRepresentation;
        _topAvatar=topAvatar;
        
        
        _txtName=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 160, 25)];
        _txtName.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16];
        
        [self.contentView addSubview:_txtName];
        
        _phoneNum=[[UILabel alloc]initWithFrame:CGRectMake(70, 30, 160, 25)];
        _phoneNum.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13];
        [self.contentView addSubview:_phoneNum];
        
 
    }
    return self;
}
-(void)setTxcolorAndTitle:(NSString*)title title:(NSString*)fid
{
    NSArray *tximgLis=@[RGB1,RGB2,RGB3,RGB4,RGB5,RGB6,RGB7,RGB8];
    NSString *strImg;
    if(fid.length!=0)//利用号码不同来随机颜色
    {
       NSString *strCarc= fid.length<7? [fid substringToIndex:fid.length]:[fid substringToIndex:7];
       int allnum=[strCarc intValue];
       strImg=tximgLis[allnum%tximgLis.count];
    }else
    {
      strImg=tximgLis[0];
    }
    
    if(title.length <= 2)
    {
        title= title;
    }else
    {
        title= [title substringWithRange:NSMakeRange(title.length - 2, 2)];
    }
    
    CDFInitialsAvatar *topAvatar = [[CDFInitialsAvatar alloc] initWithRect:_tximg.bounds fullName:title];
    
    topAvatar.backgroundColor=strImg;
    
    topAvatar.initialsFont=[UIFont fontWithName:@"STHeitiTC-Light" size:14];
    CALayer *mask = [CALayer layer]; // this will become a mask for UIImageView
    UIImage *maskImage = [UIImage imageNamed:@"AvatarMask"]; // circle, in this case
    mask.contents = (id)[maskImage CGImage];
    mask.frame = _tximg.bounds;
    _tximg.layer.mask = mask;
    _tximg.layer.cornerRadius = YES;
    _tximg.image = topAvatar.imageRepresentation;
    _topAvatar=topAvatar;
    
}
-(void)setData:(PersonModel*)personDel;
{
    _txtName.text=personDel.phonename;
    _phoneNum.text=personDel.tel;
    [self setTxcolorAndTitle:personDel.phonename title:personDel.tel];
}

@end
