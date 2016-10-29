//
//  Tools.h
//  豆瓣
//
//  Created by aaaaaa on 16/6/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

#define IMAGE(IMAGENAME, IMAGETYPE) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(IMAGENAME) ofType:(IMAGETYPE)]]

#define LEFTBAR [[UIBarButtonItem alloc] initWithImage:[IMAGE(@"btn_nav_back", @"png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)]

#define RIGHTBAR [[UIBarButtonItem alloc] initWithImage:[IMAGE(@"btn_nav_share", @"png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarAction:)]

#define FONT [UIFont systemFontOfSize:16]

@interface Tools : NSObject



+ (NSDate *)returnDate:(NSString *)string;
+ (NSString *)returnString:(NSDate *)date;

/**
 *  求很长的字符串自适应高度
 *
 *  @param text  传入整个字符串text
 *  @param width 若为求Label的高度, 传入Label的宽
 *  @param size  text的字体大小
 *
 *  @return 返回自适应求得高度
 */
+ (CGFloat)getTextHeight:(NSString *)text withWidth:(CGFloat)width withFontSize:(NSInteger)size;

/**
 *  给定宽求网络获取的图片等比压缩后的高度
 *
 *  @param imageName 传入图片的url
 *  @param width     图片限定的宽度
 *
 *  @return 返回等比压缩后图片的高度
 */

+ (CGFloat)getImageHeight:(NSString *)imageName withWidth:(CGFloat)width;


/**
 *  求短字符串自适应宽度
 *
 *  @param text 传入text
 *  @param size text的字体大小
 *
 *  @return 返回自适应宽度
 */
+ (CGFloat)getTextWidth:(NSString *)text withFontSize:(NSInteger)size;



@end
