//
//  BubbleView.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/29.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "BubbleView.h"

@interface BubbleView ()

@property (nonatomic, strong) TYQLabel *titleLabel;

@property (nonatomic, strong) UIImageView *triangleImageView;

@property (nonatomic, assign) CGFloat bubbleWidth;

@end

@implementation BubbleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.000];
        self.layer.cornerRadius = 8.f;
        self.titleLabel = [TYQLabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        
        self.triangleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _triangleImageView.backgroundColor = [UIColor grayColor];
        [self addSubview:_triangleImageView];
        
    }
    return self;
}

- (void)setFont:(CGFloat)font {
    _font = font;
    _titleLabel.font = [UIFont systemFontOfSize:font];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    _numberOfLines = numberOfLines;
    _titleLabel.numberOfLines = numberOfLines;
}

- (void)setIsLeft:(BOOL)isLeft {
    _isLeft = isLeft;
    NSLog(@"%d", isLeft);
    if (!_isLeft) {
        
        self.backgroundColor = [UIColor cyanColor];
        _triangleImageView.x = -5;

    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bubbleWidth = self.width;
    NSLog(@"%lf", _bubbleWidth);

    
    CGFloat border = 15.f;
    
    _titleLabel.frame = CGRectMake(border, border, self.width - border * 2, self.height - border * 2);
    
    _triangleImageView.frame = CGRectMake(_bubbleWidth + 5, 23, 7, 7);

    
}

@end
