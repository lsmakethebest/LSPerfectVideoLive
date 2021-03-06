

//
//  ColorAndFont.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/29.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#ifndef ColorAndFont_h
#define ColorAndFont_h


///  RGB颜色转换（16进制->10进制）
#define ARGB(rgbValue,al)                                                  \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0         \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0            \
blue:((float)(rgbValue & 0xFF)) / 255.0                     \
alpha:al]

#define RGB(rgbValue)                                                          \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0         \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0            \
blue:((float)(rgbValue & 0xFF)) / 255.0                     \
alpha:1.0]


/// 字号规定
#define KCFont1 [UIFont systemFontOfSize:18.0f]
#define KCFont2 [UIFont systemFontOfSize:17.0f]
#define KCFont3 [UIFont systemFontOfSize:16.0f]
#define KCFont4 [UIFont systemFontOfSize:15.0f]
#define KCFont5 [UIFont systemFontOfSize:14.0f]
#define KCFont6 [UIFont systemFontOfSize:13.0f]
#define KCFont7 [UIFont systemFontOfSize:12.0f]
#define KCFont8 [UIFont systemFontOfSize:11.0f]
#define KCFont9 [UIFont systemFontOfSize:10.0f]

#define KCBoldFont1 [UIFont boldSystemFontOfSize:18.0]
#define KCBoldFont2 [UIFont boldSystemFontOfSize:17.0]
#define KCBoldFont3 [UIFont boldSystemFontOfSize:16.0]
#define KCBoldFont4 [UIFont boldSystemFontOfSize:15.0]
#define KCBoldFont5 [UIFont boldSystemFontOfSize:14.0]
#define KCBoldFont6 [UIFont boldSystemFontOfSize:13.0]
#define KCBoldFont7 [UIFont boldSystemFontOfSize:12.0]
#define KCBoldFont8 [UIFont boldSystemFontOfSize:11.0]
#define KCBoldFont9 [UIFont boldSystemFontOfSize:10.0]


#define KCSystemFont(value)  [UIFont systemFontOfSize:value]

/// 颜色规定
#define KCColor1 RGB(0x333333)
#define KCColor2 RGB(0x666666)
#define KCColor3 RGB(0x8c8c8c)
#define KCColor4 RGB(0x989898)
#define KCColor5 RGB(0xcccccc)
#define KCColor6 RGB(0xffffff)
#define KCColor7 RGB(0x0079c3)
#define KCColor8 RGB(0xde4044)

#define LSThemeColor RGB(0xFB4387)

#define KCColorLine RGB(0xdddddd)


#define KCBackGroundColor RGB(0xf5f5f5)


//快速字体
#define KCFontWithSize(size)  [UIFont systemFontOfSize:size]

//随机颜色
#define RandomColor  [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]



#endif /* ColorAndFont_h */
