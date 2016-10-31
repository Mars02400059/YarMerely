//
//  BubbleView.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/29.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQView.h"

@interface BubbleView : TYQView

// 气泡显示的内容
@property (nonatomic, copy) NSString *title;
// 气泡显示的内容的字体大小
@property (nonatomic, assign) CGFloat font;
// 字行数
@property (nonatomic, assign) NSInteger numberOfLines;

@property (nonatomic, assign) BOOL isLeft;
// 图片
@property (nonatomic, strong) UIImageView *chatImageView;


@end
