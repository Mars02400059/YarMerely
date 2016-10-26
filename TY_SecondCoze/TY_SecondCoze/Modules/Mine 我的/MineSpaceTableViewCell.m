//
//  MineSpaceTableViewCell.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/25.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineSpaceTableViewCell.h"

@interface MineSpaceTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MineSpaceTableViewCell

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
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
