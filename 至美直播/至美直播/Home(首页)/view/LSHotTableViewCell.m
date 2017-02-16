

//
//  LSHotTableViewCell.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSHotTableViewCell.h"

@interface LSHotTableViewCell ()

@property (weak, nonatomic) IBOutlet LSRenderImageView *headIcon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *levelImage;
@property (weak, nonatomic) IBOutlet UILabel *location;


@property (weak, nonatomic) IBOutlet UILabel *peopleNumber;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation LSHotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(LSUserModel *)model
{
    _model=model;
    [self.backgroundImage setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:nil];
     [self.headIcon setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:nil];
    self.location.text=model.gps;
    self.levelImage.image=[UIImage imageNamed:[NSString stringWithFormat: @"girl_star%d_40x19_",model.starlevel+1]];
    self.name.text=model.myname;
    self.peopleNumber.text=model.allnum;
    
}
@end
