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
        
        
        self.backColor = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_backColor];
        
        self.titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:19.f];
        [self addSubview:_titleLabel];
        
        self.leftButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
        self.rightButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonWidth = 44;
    CGFloat buttonX = 5;
    CGFloat Y = 20;
    CGFloat titleX = buttonX + buttonWidth;
    CGFloat titleWidth = self.height - 2 * titleX;
    CGFloat Height = self.height - Y;
    _titleLabel.frame = CGRectMake(titleX, Y, titleWidth, Height);
    _leftButton.frame = CGRectMake(buttonX, Y, buttonWidth, buttonWidth);
    _rightButton.frame = CGRectMake(self.width - buttonWidth - buttonX, Y, buttonWidth, Height);

    
    
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
