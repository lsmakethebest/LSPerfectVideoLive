//
//  NSString+LSExtension.h
//  driver
//
//  Created by 刘松 on 16/8/30.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LSExtension)


#pragma mark - 是否匹配指定正则表达式
-(BOOL)validWithRegularString:(NSString*)regularString;

/*
 *获取汉字拼音的首字母, 返回的字母是大写形式, 例如: @"俺妹", 返回 @"A".
 *如果字符串开头不是汉字, 而是字母, 则直接返回该字母, 例如: @"b彩票", 返回 @"B".
 *如果字符串开头不是汉字和字母, 则直接返回 @"#", 例如: @"&哈哈", 返回 @"#".
 *字符串开头有特殊字符(空格,换行)不影响判定, 例如@"       a啦啦啦", 返回 @"A".
 */
- (NSString *)getFirstLetter;



//将十六进制的编码转为emoji字符
+ (NSString *)emojiWithIntCode:(int)intCode;

// 将十六进制的编码转为emoji字
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;

//是否为emoji字符
- (BOOL)isEmoji;

// 返回单行字符串大小
- (CGSize)sizeWithfont:(UIFont *)font;

// 返回多行字符串大小
- (CGSize)sizeWithfont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

// 返回设置行间距的字符串大小
- (CGSize)sizeWithfont:(UIFont *)font
              maxWidth:(CGFloat)maxWidth
           lineSpacing:(CGFloat)lineSpacing;
// 返回设置行间距与段落间距的字符串大小
- (CGSize)sizeWithfont:(UIFont *)font
              maxWidth:(CGFloat)maxWidth
           lineSpacing:(CGFloat)lineSpacing
      paragraphSpacing:(CGFloat)paragraphSpacing;

#pragma mark - 计算文件或目录大小
- (CGFloat)fileSizeWithFilePath;

@end


@interface NSArray (LSExtension)

/*
 *将一个字符串数组按照拼音首字母规则进行重组排序, 返回重组后的数组.
 *格式和规则为:
 
 [
 @{
 @"firstLetter": @"A",
 @"content": @[@"啊", @"阿狸"]
 }
 ,
 @{
 @"firstLetter": @"B",
 @"content": @[@"部落", @"帮派"]
 }
 ,
 ...
 ]
 
 *只会出现有对应元素的字母字典, 例如: 如果没有对应 @"C"的字符串出现, 则数组内也不会出现 @"C"的字典.
 *数组内字典的顺序按照26个字母的顺序排序
 *@"#"对应的字典永远出现在数组最后一位
 */
- (NSArray *)arrayWithPinYinFirstLetterFormat;

@end


