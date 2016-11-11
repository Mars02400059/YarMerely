//
//  TYQLabel.m
//  Tenyar
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQLabel.h"

@implementation TYQLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#warning 基类label添加了背景颜色
//        self.backgroundColor = [UIColor grayColor];
        
        self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xFFFAFA,0xBEBEBE);
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
