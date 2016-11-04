//
//  Tools.m
//  豆瓣
//
//  Created by aaaaaa on 16/6/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Tools.h"



@implementation Tools


+ (NSDate *)returnDate:(NSString *)string{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [fomatter dateFromString:string];
}

+ (NSString *)returnString:(NSDate *)date{
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    return [dateFormatter stringFromDate:date];
}

/**
 *  求很长的字符串自适应高度
 *
 *  @param text  传入整个字符串text
 *  @param width 若为求Label的高度, 传入Label的宽
 *  @param size  text的字体大小
 *
 *  @return 返回自适应求得高度
 */
+ (CGFloat)getTextHeight:(NSString *)text withWidth:(CGFloat)width withFontSize:(NSInteger)size{
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:size]
                          };
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
    
}

/**
 *  求短字符串自适应宽度
 *
 *  @param text 传入text
 *  @param size text的字体大小
 *
 *  @return 返回自适应宽度
 */
+ (CGFloat)getTextWidth:(NSString *)text withFontSize:(NSInteger)size{
    
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:size]
                          };
    CGRect rect = [text boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic                                  context:nil];
    return rect.size.width;
    
}

/**
 *  给定宽求网络获取的图片等比压缩后的高度
 *
 *  @param imageName 传入图片的url
 *  @param width     图片限定的宽度
 *
 *  @return 返回等比压缩后图片的高度
 */

+ (CGFloat)getImageHeight:(NSString *)imageName withWidth:(CGFloat)width{
    NSURL *imageURL = [NSURL URLWithString:imageName];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    CGFloat imageHeight = image.size.height / image.size.width * width;
    return imageHeight;
}















@end
