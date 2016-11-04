//
//  PersonInfoTextField.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/3.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "PersonInfoTextField.h"

@implementation PersonInfoTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.infoLabel = [TYQLabel new];
        _infoLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_infoLabel];
        
        self.infoTextField = [UITextField new];
        _infoTextField.backgroundColor = [UIColor whiteColor];
        [self addSubview:_infoTextField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _infoLabel.frame = CGRectMake(8, 10, 42, 30);
    
    _infoTextField.frame = CGRectMake(55, 10, self.width - 70, self.height - 20);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
