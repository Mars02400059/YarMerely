//
//  PhoneView.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "PhoneView.h"
#import "PhoneButton.h"

@interface PhoneView ()
<
PhoneButtonDelegate
>
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) PhoneButton *phoneButton;




@end



@implementation PhoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [UILabel new];
        _titleLabel.text = @"点击请慎重";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        self.phoneButton = [[PhoneButton alloc] initWithImage:[UIImage imageNamed:@""]];
        _phoneButton.delegate = self;
        _phoneButton.userInteractionEnabled = YES;
        _phoneButton.backgroundColor = [UIColor redColor];
        [self addSubview:_phoneButton];
    }
    return self;
}

- (void)tyq_touchesBegan {
    [self.delegate tyq_touchesBegan];
}

- (void)tyq_touchesEnded {
    [self.delegate tyq_touchesEnded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(self.width / 2 - 35, 5, 70, 20);
    
    _phoneButton.frame = CGRectMake((self.width - 100) / 2, 50, 100, 100);
}

@end
