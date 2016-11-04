//
//  ConnectCollectionViewCell.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/26.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "ConnectCollectionViewCell.h"



@interface ConnectCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *label;

@end


@implementation ConnectCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createSubView];
        
    }
    
    return self;
}


-(void)createSubView{
    
    self.imageV = [UIImageView new];
//    self.imageV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imageV];
    
    self.label = [UILabel new];
//    _label.backgroundColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
    _label.font = [UIFont systemFontOfSize:20];
    _label.textColor = [UIColor blackColor];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _imageV.frame = CGRectMake(self.contentView.frame.size.width / 3 / 2, 0, self.contentView.frame.size.width / 3 * 2   , self.contentView.frame.size.width / 3 * 2);
    _label.frame = CGRectMake(0, self.contentView.frame.size.width/ 3 * 2 + 5, self.contentView.frame.size.width,self.contentView.frame.size.height / 3 - 5);
}


-(void)setStringImage:(NSString *)stringImage{
    
    _stringImage = stringImage;
    
    _imageV.image = [UIImage imageNamed:stringImage];
    
}

-(void)setStringWord:(NSString *)stringWord{
    
    _stringWord = stringWord;
    
    _label.text = stringWord;
}











@end
