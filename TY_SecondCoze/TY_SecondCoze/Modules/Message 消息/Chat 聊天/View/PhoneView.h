//
//  PhoneView.h
//  TY_SecondCoze
//
//  Created by mars on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQView.h"
@class PhoneButton;

@protocol PhoneViewDelegate <NSObject>
/// 触发开始
- (void)tyq_touchesBegan;
/// 触发结束
- (void)tyq_touchesEnded;

@end


@interface PhoneView : TYQView

@property (nonatomic, assign) id<PhoneViewDelegate>delegate;


@end
