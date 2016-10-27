//
//  TextFieldView.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/21.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TextFieldView.h"

@interface TextFieldView ()

@property (nonatomic, strong) UILabel *titleLabel;



@end

@implementation TextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        
        self.textField = [TYQTextField new];
        [self addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    _titleLabel.frame = CGRectMake(0, 0, 70, 

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
