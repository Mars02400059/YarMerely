
//
//  ConnectTableViewCell.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/26.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "ConnectTableViewCell.h"

@interface ConnectTableViewCell ()

@end

@implementation ConnectTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createSubView];
    }
    return self;
}


-(void)createSubView{
    
    self.imageV = [UIImageView new];
    [self.contentView addSubview:_imageV];
    
    self.nameLable = [UILabel new];
    [self.contentView addSubview:_nameLable];
    _nameLable.font = [UIFont systemFontOfSize:22];
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _imageV.frame = CGRectMake(20, 20, self.contentView.frame.size.width / 8, self.contentView.frame.size.width / 8);
    _nameLable.frame = CGRectMake(_imageV.frame.size.width + _imageV.frame.origin.x + 10, (self.contentView.frame.size.height - 20) / 2, self.width / 2, self.contentView.frame.size.width / 10 / 2);
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
