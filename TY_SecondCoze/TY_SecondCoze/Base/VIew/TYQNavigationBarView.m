//
//  TYQNavigationBarView.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/23.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQNavigationBarView.h"

@interface TYQNavigationBarView ()

@property (nonatomic, strong) UILabel *titleLabel;



@end

@implementation TYQNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat buttonWidth = 44;
        CGFloat buttonX = 5;
        CGFloat Y = 20;
        CGFloat titleX = buttonX + buttonWidth;
        CGFloat titleWidth = frame.size.height - 2 * titleX;
        CGFloat Height = frame.size.height - Y;
        
        self.backColor = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_backColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, Y, titleWidth, Height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:19.f];
        [self addSubview:_titleLabel];
        
        self.leftButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(buttonX, Y, buttonWidth, buttonWidth);
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
        self.rightButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(frame.size.width - buttonWidth - buttonX, Y, buttonWidth, Height);
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setTitleFont:(CGFloat)titleFont {
    _titleFont = titleFont;
    _titleLabel.font = [UIFont systemFontOfSize:titleFont];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)setLeftButtonImage:(UIImage *)leftButtonImage {
    _leftButtonImage = leftButtonImage;
    [_leftButton setImage:leftButtonImage forState:UIControlStateNormal];
}
- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    _rightButtonImage = rightButtonImage;
    [_rightButton setImage:rightButtonImage forState:UIControlStateNormal];
}
- (void)leftButtonAction {
    [self.delegate tyq_navigationBarViewLeftButtonAction];
}

- (void)rightButtonAction {
    [self.delegate tyq_navigationBarViewRightButtonAction];
}

@end
