//
//  StationView.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/28.
//  Copyright © 2016年 TengYa. All rights reserved.
//

// 功能操作台

#import "TYQView.h"

@protocol StationViewDelegate <NSObject>
/// 点击加号按钮后的点击方法, record记录点击的次数, YES为第一次点击, NO为第二次点击
- (void)tyq_butttonClickSendMessageDelegate:(BOOL)record;

/// 点击键盘return的点击方法
- (void)tyq_actionTextFieldReturn;


/// 点击语音按钮的点击方法 record记录点击的次数, YES为第一次点击, NO为第二次点击
- (void)tyq_phoneFunctionDelegate:(BOOL)record;


/// 点击表情按钮后的点击方法 record记录点击的次数, YES为第一次点击, NO为第二次点击
- (void)tyq_expressionDelegate:(BOOL)record;


@end

@interface StationView : TYQView

// 输入框
@property (nonatomic, strong) TYQTextField *importTextField;


@property (nonatomic, assign) id<StationViewDelegate>delegate;

/// 将所有button的record还原
- (void)tyq_allButtonRecordReduction;

@end
