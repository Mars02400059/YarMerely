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

- (void)tyq_butttonClickSendMessageDelegate;

- (void)tyq_actionTextFieldReturn;


@end

@interface StationView : TYQView

// 输入框
@property (nonatomic, strong) TYQTextField *importTextField;

@property (nonatomic, assign) id<StationViewDelegate>delegate;

@end
