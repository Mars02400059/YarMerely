//
//  MoreFunctionView.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MoreFunctionView.h"

@implementation MoreFunctionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _photoButton.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        [_photoButton setTitle:@"添加图片" forState:UIControlStateNormal];
        [_photoButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_photoButton addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_photoButton];
    }
    return self;
}

- (void)photoButtonAction:(TYQButton *)photoButton {
    [self.delegate tyq_addPhotoActionDelegate];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat X = 20.f;
    CGFloat Y = 20.f;
    CGFloat Width = (WIDTH - X * 5) / 4;
    CGFloat Height = Width;
    _photoButton.frame = CGRectMake(X, Y, Width, Height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
