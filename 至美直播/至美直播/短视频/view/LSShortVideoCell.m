




//
//  LSShortVideoCell.m
//  至美直播
//
//  Created by 刘松 on 2017/1/18.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSShortVideoCell.h"

@interface LSShortVideoCell ()

@property (weak, nonatomic) IBOutlet LSRenderImageView *headIcon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation LSShortVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(LSShortVideoModel *)model
{
    
    _model=model;
    
    self.name.text=model.username;
    [self.headIcon setImageWithURL:[NSURL URLWithString:model.headicon] placeholderImage:[UIImage imageNamed:@"default_person_head_5"]];
    
    [self.backgroundImage setImageWithURL:[NSURL URLWithString:StringFormat(LSQNFileHost, model.thumbnail_image)] placeholderImage:[UIImage imageNamed:@"default_ticker"]];

    
}
@end
