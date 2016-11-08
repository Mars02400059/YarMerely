//
//  MineImageTableViewCell.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/25.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineImageTableViewCell.h"

@interface MineImageTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation MineImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
