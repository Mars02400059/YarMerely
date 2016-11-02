//
//  MoreFunctionView.h
//  TY_SecondCoze
//
//  Created by mars on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQView.h"

@protocol MoreFunctionViewDelegate <NSObject>
/// 点击添加图片按钮
- (void)tyq_addPhotoActionDelegate;

/// 点击语音通话按钮
- (void)tyq_addVoiceActionDelegate;

/// 点击视频通话按钮
- (void)tyq_addVideoActionDelegate;

@end

@interface MoreFunctionView : TYQView



@property (nonatomic, assign) id<MoreFunctionViewDelegate>delegate;

@end
