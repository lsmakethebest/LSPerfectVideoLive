//
//  ETIMonthHeaderView.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarMonthHeaderView.h"
#import "Color.h"

#define BackgroundColor [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.618];
@interface CalendarMonthHeaderView ()
@property (weak, nonatomic) UILabel *day1OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day2OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day3OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day4OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day5OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day6OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day7OfTheWeekLabel;
@end


#define CATDayLabelWidth  40.0f
#define CATDayLabelHeight 20.0f

@implementation CalendarMonthHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.backgroundColor=[UIColor whiteColor];
       
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        [self setup];
        
    }
    return self;
}

- (void)setup
{
    
    self.clipsToBounds = YES;
    
    //月份
    UILabel *masterLabel = [[UILabel alloc] init];
    [masterLabel setBackgroundColor:[UIColor clearColor]];
    [masterLabel setTextAlignment:NSTextAlignmentCenter];
    [masterLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    self.masterLabel = masterLabel;
    self.masterLabel.textColor = COLOR_THEME;
    [self addSubview:self.masterLabel];
    
    CGFloat xOffset = 5.0f;
    CGFloat yOffset = 45.0f;

    //一，二，三，四，五，六，日
    UILabel *dayOfTheWeekLabel = [[UILabel alloc]init];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day1OfTheWeekLabel = dayOfTheWeekLabel;
    self.day1OfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    self.day1OfTheWeekLabel.textColor = COLOR_THEME1;
    [self addSubview:self.day1OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day2OfTheWeekLabel = dayOfTheWeekLabel;
    self.day2OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day2OfTheWeekLabel.textColor = COLOR_THEME;
    [self addSubview:self.day2OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day3OfTheWeekLabel = dayOfTheWeekLabel;
    self.day3OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day3OfTheWeekLabel.textColor = COLOR_THEME;
    [self addSubview:self.day3OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day4OfTheWeekLabel = dayOfTheWeekLabel;
    self.day4OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day4OfTheWeekLabel.textColor = COLOR_THEME;
    [self addSubview:self.day4OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day5OfTheWeekLabel = dayOfTheWeekLabel;
    self.day5OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day5OfTheWeekLabel.textColor = COLOR_THEME;
    [self addSubview:self.day5OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day6OfTheWeekLabel = dayOfTheWeekLabel;
    self.day6OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day6OfTheWeekLabel.textColor = COLOR_THEME;
    [self addSubview:self.day6OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day7OfTheWeekLabel = dayOfTheWeekLabel;
    self.day7OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day7OfTheWeekLabel.textColor = COLOR_THEME1;
    [self addSubview:self.day7OfTheWeekLabel];
    
    [self updateWithDayNames:@[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]];
    
}


//设置 @"日", @"一", @"二", @"三", @"四", @"五", @"六"
- (void)updateWithDayNames:(NSArray *)dayNames
{
    for (int i = 0 ; i < dayNames.count; i++) {
        switch (i) {
            case 0:
                self.day1OfTheWeekLabel.text = dayNames[i];
                break;

            case 1:
                self.day2OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 2:
                self.day3OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 3:
                self.day4OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 4:
                self.day5OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 5:
                self.day6OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 6:
                self.day7OfTheWeekLabel.text = dayNames[i];
                break;
                
            default:
                break;
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat yOffset=20;
    _masterLabel.frame=CGRectMake(0, 0, self.frame.size.width, yOffset);
    
    CGFloat width=self.frame.size.width/7;
    self.day1OfTheWeekLabel.frame=CGRectMake(0, yOffset, width, 25);
    self.day2OfTheWeekLabel.frame=CGRectMake(width, yOffset, width, 25);
    self.day3OfTheWeekLabel.frame=CGRectMake(width*2, yOffset, width, 25);
    self.day4OfTheWeekLabel.frame=CGRectMake(width*3, yOffset, width, 25);
    self.day5OfTheWeekLabel.frame=CGRectMake(width*4, yOffset, width, 25);
    self.day6OfTheWeekLabel.frame=CGRectMake(width*5, yOffset, width, 25);
    self.day7OfTheWeekLabel.frame=CGRectMake(width*6, yOffset, width, 25);
}



@end
