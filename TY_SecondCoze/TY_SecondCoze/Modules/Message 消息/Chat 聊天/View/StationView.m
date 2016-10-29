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
        [_phoneButton setImage:[UIImage imageNamed:@"聊天语音"] forState:UIControlStateNormal];
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
        [_expressionButton setImage:[UIImage imageNamed:@"聊天表情"] forState:UIControlStateNormal];
        [self addSubview:_expressionButton];
        
        self.moreButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setImage:[UIImage imageNamed:@"聊天加号"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.delegate tyq_actionTextFieldReturn];
    
    return YES;
}

- (void)moreButtonAction {
    [self.delegate tyq_butttonClickSendMessageDelegate];
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
