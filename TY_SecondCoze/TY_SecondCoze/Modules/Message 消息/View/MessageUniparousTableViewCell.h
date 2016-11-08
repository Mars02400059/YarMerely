//
//  MessageUniparousTableViewCell.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQTableViewCell.h"

@interface MessageUniparousTableViewCell : TYQTableViewCell

@property (nonatomic, strong) EMConversation *conversation;
@property (nonatomic, strong) TYQImageView *myImageView;

@property (nonatomic, strong) TYQLabel *titleLabel;

@property (nonatomic, strong) TYQLabel *cententLabel;

@property (nonatomic, strong) TYQLabel *timeLabel;


@end
