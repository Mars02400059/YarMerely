//
//  MineDatumTableViewCell.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/26.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineDatumTableViewCell.h"

@interface MineDatumTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation MineDatumTableViewCell

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setInfo:(NSString *)info {
    _info = info;
    _infoLabel.text = info;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
