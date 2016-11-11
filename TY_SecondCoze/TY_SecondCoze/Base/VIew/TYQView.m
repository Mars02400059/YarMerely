//
//  TYQView.m
//  Tenyar
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQView.h"

@implementation TYQView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xFFFAFA,0xBEBEBE);
//        self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithRGB(0x1E90FF,0xCDCDB4);
//        self.navigationController.navigationBar.dk_tintColorPicker = DKColorPickerWithRGB(0xFAFAD2,0x1C1C1C);
        

        
    }
    return self;
}







@end
