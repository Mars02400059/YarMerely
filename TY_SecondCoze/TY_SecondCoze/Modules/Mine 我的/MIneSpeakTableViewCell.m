//
//  MIneSpeakTableViewCell.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/8.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MIneSpeakTableViewCell.h"

@implementation MIneSpeakTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.speakImageView = [TYQImageView new];
        [self.contentView addSubview:_speakImageView];
        
        self.speakTextLabel = [TYQLabel new];
        _speakTextLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_speakTextLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _speakTextLabel.frame = CGRectMake(10, 10, self.width - 20, 30);
    
    _speakImageView.frame = CGRectMake(10, 45, 150, 180);
    
}



@end
