//
//  ConnetMessageViewController.h
//  TY_SecondCoze
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//
// 处理请求(同意或者拒绝)

#import "TYQViewController.h"
#import "InfoModel.h"


@protocol ConnetMessageViewControllerDelegate <NSObject>

- (void)tyq_agreeButtonActionDelegate;

@end

@interface ConnetMessageViewController : TYQViewController

@property (nonatomic, strong) InfoModel *infoModelMessage;

@property (nonatomic, assign) id<ConnetMessageViewControllerDelegate>delegate;

@end
