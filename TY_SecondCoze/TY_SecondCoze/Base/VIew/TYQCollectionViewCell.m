//
//  TYQCollectionViewCell.m
//  Tenyar
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQCollectionViewCell.h"

@implementation TYQCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xFFFFFF,0xC1CDCD);
    }
    return self;
}


@end
