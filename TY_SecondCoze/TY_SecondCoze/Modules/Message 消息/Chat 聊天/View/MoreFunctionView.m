//
//  MoreFunctionView.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MoreFunctionView.h"

@interface MoreFunctionView ()

/// 添加图片
@property (nonatomic, strong) TYQButton *photoButton;
/// 语音通话
@property (nonatomic, strong) TYQButton *voiceCallButton;
/// 视频通话
@property (nonatomic, strong) TYQButton *videoCallButton;

@end


@implementation MoreFunctionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _photoButton.backgroundColor = [UIColor whiteColor];
        _photoButton.layer.cornerRadius = 8.f;
        _photoButton.clipsToBounds = YES;
        _photoButton.layer.borderColor = [UIColor grayColor].CGColor;
        _photoButton.layer.borderWidth = 0.5f;
        [_photoButton setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
        [_photoButton addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_photoButton];
        
        self.voiceCallButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _voiceCallButton.backgroundColor = [UIColor whiteColor];
        _voiceCallButton.layer.cornerRadius = 8.f;
        _voiceCallButton.clipsToBounds = YES;
        _voiceCallButton.layer.borderColor = [UIColor grayColor].CGColor;
        _voiceCallButton.layer.borderWidth = 0.5f;
        [_voiceCallButton setImage:[UIImage imageNamed:@"语音通话"] forState:UIControlStateNormal];
        [_voiceCallButton addTarget:self action:@selector(voiceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_voiceCallButton];
        
        self.videoCallButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _videoCallButton.backgroundColor = [UIColor whiteColor];
        _videoCallButton.layer.cornerRadius = 8.f;
        _videoCallButton.clipsToBounds = YES;
        _videoCallButton.layer.borderColor = [UIColor grayColor].CGColor;
        _videoCallButton.layer.borderWidth = 0.5f;
        [_videoCallButton setImage:[UIImage imageNamed:@"视频通话"] forState:UIControlStateNormal];
        [_videoCallButton addTarget:self action:@selector(videoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_videoCallButton];
        
    }
    return self;
}

- (void)photoButtonAction:(TYQButton *)photoButton {
    [self.delegate tyq_addPhotoActionDelegate];
}
- (void)voiceButtonAction:(TYQButton *)voiceButton {
    [self.delegate tyq_addVoiceActionDelegate];
}
- (void)videoButtonAction:(TYQButton *)videoButton {
    [self.delegate tyq_addVideoActionDelegate];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat X = 20.f;
    CGFloat Y = 20.f;
    CGFloat Width = (WIDTH - X * 5) / 4;
    CGFloat Height = Width;
    _photoButton.frame = CGRectMake(X, Y, Width, Height);
    
    _voiceCallButton.frame = CGRectMake(X * 2 + Width, Y, Width, Height);
    _videoCallButton.frame = CGRectMake(X * 3 + Width * 2, Y, Width, Height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
