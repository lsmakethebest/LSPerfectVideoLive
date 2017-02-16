

//
//  LSLiveMaskTopView.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSLiveMaskTopView.h"

@interface LSLiveMaskTopView ()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet LSRenderImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end
@implementation LSLiveMaskTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setModel:(LSUserModel *)model
{
    _model=model;
    [self.icon setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"header_default_100x100_"]];
    self.name.text=model.myname;
    self.number.text=model.allnum;
    
    
}
@end
