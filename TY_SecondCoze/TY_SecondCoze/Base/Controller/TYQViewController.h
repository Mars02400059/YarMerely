//
//  TYQViewController.h
//  Tenyar
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYQNavigationBarView.h"

@interface TYQViewController : UIViewController
<
TYQNavigationBarViewDelegate
>

// 自定义假导航
@property (nonatomic, strong) TYQNavigationBarView *navigationBarView;
/// 添加假导航的方法
- (void)addNavigationBarView;


@end
