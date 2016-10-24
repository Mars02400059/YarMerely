//
//  TYQNavigationBarView.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/23.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQView.h"

@protocol TYQNavigationBarViewDelegate <NSObject>
// 点击左按钮的协议方法
- (void)tyq_navigationBarViewLeftButtonAction;
// 点击右按钮的协议方法
- (void)tyq_navigationBarViewRightButtonAction;

@end

@interface TYQNavigationBarView : TYQView
// 点击按钮的协议
@property (nonatomic, assign) id<TYQNavigationBarViewDelegate>delegate;
// 导航标题名字
@property (nonatomic, copy) NSString *title;
// 导航标题字体大小
@property (nonatomic, assign) CGFloat titleFont;
// 导航标题字体颜色
@property (nonatomic, strong) UIColor *titleColor;
// 左按钮背景图片
@property (nonatomic, strong) UIImage *leftButtonBackImage;
// 右按钮背景图片
@property (nonatomic, strong) UIImage *rightButtonBackImage;


@end
