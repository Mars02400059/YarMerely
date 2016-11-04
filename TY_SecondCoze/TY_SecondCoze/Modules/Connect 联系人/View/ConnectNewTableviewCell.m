//
//  ConnectNewTableviewCell.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "ConnectNewTableviewCell.h"

@interface ConnectNewTableviewCell ()

@property (nonatomic, strong) TYQLabel *newsLabel;

@end

@implementation ConnectNewTableviewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self createSubView];
    }
    
    return self;
}

-(void) createSubView{
    
    self.newsLabel = [TYQLabel new];
    _newsLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_newsLabel];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _newsLabel.frame = CGRectMake(10, self.contentView.frame.size.height / 4, self.contentView.frame.size.width / 3 * 2, self.contentView.frame.size.height - (self.contentView.frame.size.height / 4) * 2);
    
}



-(void)setInfoModel:(InfoModel *)infoModel{
    
    _infoModel = infoModel;
    
    NSString *string = @"请求加您为好友";
    
    _newsLabel.text = [infoModel.username stringByAppendingString:  string];
    
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
