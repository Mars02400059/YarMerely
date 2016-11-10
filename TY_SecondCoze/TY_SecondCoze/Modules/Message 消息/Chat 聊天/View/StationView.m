//
//  StationView.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/28.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "StationView.h"

@interface StationView ()
<
UITextFieldDelegate
>
// 语音
@property (nonatomic, strong) TYQButton *phoneButton;
// 表情
@property (nonatomic, strong) TYQButton *expressionButton;
// 更多功能
@property (nonatomic, strong) TYQButton *moreButton;


@end

@implementation StationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.phoneButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _phoneButton.record = NO;
        [_phoneButton setImage:[UIImage imageNamed:@"聊天语音"] forState:UIControlStateNormal];
        [_phoneButton addTarget:self action:@selector(phoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_phoneButton];
        
        self.importTextField = [TYQTextField new];
        _importTextField.clearsOnBeginEditing = YES;
        _importTextField.delegate = self;
        _importTextField.backgroundColor = [UIColor whiteColor];
        _importTextField.layer.cornerRadius = 10.f;
        _importTextField.layer.borderWidth = 1.f;
        _importTextField.layer.borderColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.000].CGColor;
        [self addSubview:_importTextField];
        
        self.expressionButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _expressionButton.record = NO;
        [_expressionButton setImage:[UIImage imageNamed:@"聊天表情"] forState:UIControlStateNormal];
        [_expressionButton addTarget:self action:@selector(expressionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_expressionButton];
        
        self.moreButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        _moreButton.record = NO;
        [_moreButton setImage:[UIImage imageNamed:@"聊天加号"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        
        
        
    }
    return self;
}
// 输入框的return按键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [self.delegate tyq_actionTextFieldReturn];
    
    return YES;
}

/// 加号
- (void)moreButtonAction:(TYQButton *)moreButton {
    if (!moreButton.record) {
        moreButton.record = YES;
    } else {
        moreButton.record = NO;
    }
    [self.delegate tyq_butttonClickSendMessageDelegate:moreButton.record];
}
/// 语音按钮
- (void)phoneButtonAction:(TYQButton *)phoneButton {
    if (!phoneButton.record) {
        [phoneButton setImage:[UIImage imageNamed:@"聊天键盘"] forState:UIControlStateNormal];
        phoneButton.record = YES;
        
    } else {
        [phoneButton setImage:[UIImage imageNamed:@"聊天语音"] forState:UIControlStateNormal];
        phoneButton.record = NO;
    }
    [self.delegate tyq_phoneFunctionDelegate:phoneButton.record];
}
// 表情按钮
- (void)expressionButtonAction:(TYQButton *)expressionButton {
    
    if (!expressionButton.record) {
        [expressionButton setImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
        expressionButton.record = YES;
        
    } else {
        [expressionButton setImage:[UIImage imageNamed:@"聊天表情"] forState:UIControlStateNormal];
        expressionButton.record = NO;
    }
    [self.delegate tyq_expressionDelegate:expressionButton.record];
    
}

- (void)tyq_allButtonRecordReduction {
    _moreButton.record = NO;
    _phoneButton.record = NO;
    _expressionButton.record = NO;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat phoneButtonX = 10.f;
    CGFloat buttonY = 12.f;
    CGFloat buttonHeight = self.height - buttonY * 2;
    CGFloat buttonWidth = buttonHeight;
    
    _phoneButton.frame = CGRectMake(phoneButtonX, buttonY, buttonWidth, buttonHeight);
    
    CGFloat moreButtonX = self.width - phoneButtonX - buttonWidth;
    _moreButton.frame = CGRectMake(moreButtonX, buttonY, buttonWidth, buttonHeight);
    
    
    CGFloat expressionButtonX = moreButtonX - phoneButtonX / 3 - buttonWidth;
    _expressionButton.frame = CGRectMake(expressionButtonX, buttonY, buttonWidth, buttonHeight);
    
    CGFloat importTextFieldX = phoneButtonX * 2 + buttonWidth;
    CGFloat importTextFieldY = 12.f;
    CGFloat importTextFieldWidth = expressionButtonX - buttonWidth - phoneButtonX * 3;
    CGFloat importTextFieldHeight = self.height - importTextFieldY * 2;
    _importTextField.frame = CGRectMake(importTextFieldX, importTextFieldY, importTextFieldWidth, importTextFieldHeight);
    
}


@end
