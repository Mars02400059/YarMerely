//
//  BubbleView.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/29.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "BubbleView.h"
#import "Tools.h"


@interface BubbleView ()

@property (nonatomic, strong) TYQLabel *titleLabel;

@property (nonatomic, strong) UIImageView *triangleImageView;

@property (nonatomic, assign) CGFloat bubbleWidth;



@end

@implementation BubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8.f;
        self.titleLabel = [TYQLabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        
        self.triangleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [self addSubview:_triangleImageView];
        
        self.chatImageView = [UIImageView new];
        _chatImageView.clipsToBounds = YES;
        _chatImageView.layer.cornerRadius = 8.f;
        [self addSubview:_chatImageView];
        
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
    
    CGFloat bubbleX;
    CGFloat bubbleWidth;
    CGFloat bubbleHeight;
    CGFloat border = 15.f;
    CGFloat bubbleTextWidthMax = WIDTH - (10 * 2 + 50) * 2 - border * 2;
    
    CGFloat bubbleTextWidth;
    CGFloat bubbleTextHeight;
    CGFloat textWidth = [Tools getTextWidth:title withFontSize:20.f];
    if (textWidth < bubbleTextWidthMax) {
        bubbleTextWidth = textWidth;
        bubbleTextHeight = 22.f;
    } else {
        CGFloat textHeight = [Tools getTextHeight:title withWidth:bubbleTextWidthMax withFontSize:20];
        bubbleTextWidth = bubbleTextWidthMax;
        bubbleTextHeight = textHeight;
    }
    bubbleWidth = bubbleTextWidth + border * 2;
    bubbleHeight = bubbleTextHeight + border * 2;
    
    bubbleX = 10.f - 10 - bubbleWidth;
    
    _triangleImageView.frame = CGRectMake(bubbleWidth - 3, 20, 10, 10);
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    _numberOfLines = numberOfLines;
    _titleLabel.numberOfLines = numberOfLines;
}

- (void)setIsLeft:(BOOL)isLeft {
    _isLeft = isLeft;
    if (!_isLeft) {
        
        self.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.000];
        _triangleImageView.image = [UIImage imageNamed:@"气泡左"];
        _triangleImageView.frame = CGRectMake(-7, 20, 10, 10);

    } else {
        self.backgroundColor = [UIColor colorWithRed:0.57 green:0.95 blue:0.95 alpha:1.000];
        _triangleImageView.image = [UIImage imageNamed:@"气泡右"];
        
    }
    
}

- (void)tyq_bubbleWidth:(CGFloat)bubbleWidth {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bubbleWidth = self.width;
    
    
    CGFloat border = 15.f;
    
    _titleLabel.frame = CGRectMake(border, border, self.width - border * 2, self.height - border * 2);
    
    _chatImageView.frame = CGRectMake(2, 2, self.width - 2 * 2, self.height - 2 * 2);
    
}

@end
