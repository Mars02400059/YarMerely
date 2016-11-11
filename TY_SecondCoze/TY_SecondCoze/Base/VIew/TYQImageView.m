//
//  TYQImageView.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/21.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQImageView.h"

@implementation TYQImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xFFFFFF,0xC1CDCD);
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
