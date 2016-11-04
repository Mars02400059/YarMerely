//
//  MessageUniparousTableViewCell.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageUniparousTableViewCell.h"
#import "NSDate+Categories.h"


@interface MessageUniparousTableViewCell ()

@property (nonatomic, strong) TYQImageView *myImageView;

@property (nonatomic, strong) TYQLabel *titleLabel;

@property (nonatomic, strong) TYQLabel *cententLabel;

@property (nonatomic, strong) TYQLabel *timeLabel;


@end


@implementation MessageUniparousTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myImageView = [TYQImageView new];
        self.myImageView.image = [UIImage imageNamed:@"默认头像"];
        [self.contentView addSubview:_myImageView];
        
        self.titleLabel = [TYQLabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:20.f];
        [self.contentView addSubview:_titleLabel];
        
        self.cententLabel = [TYQLabel new];
        _cententLabel.backgroundColor = [UIColor clearColor];
        _cententLabel.font = [UIFont systemFontOfSize:16.f];
        _cententLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_cententLabel];
        
        self.timeLabel = [TYQLabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:13.f];
        _timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLabel];
        
        
    }
    return self;
}


- (void)setConversation:(EMConversation *)conversation {
    _conversation = conversation;

    _titleLabel.text = [conversation chatter];
    // 最后一条消息
    
    id<IEMMessageBody> messageBody = conversation.latestMessage.messageBodies.firstObject;
    if (conversation.latestMessage) {
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                _cententLabel.text = ((EMTextMessageBody *)messageBody).text;
            }
                break;
                
            case eMessageBodyType_Image:
            {
                _cententLabel.text = @"图片";
            }
                break;
                
            case eMessageBodyType_Voice:
            {
                _cententLabel.text = @"语音";
            }
                break;
                
            default:
                break;
        }
    } else {
        
        _cententLabel.text = @"";
    }
    
    
    
    
    // 时间
    _timeLabel.text = [NSDate intervalSinceNow:messageBody.message.timestamp];
    
    // 未读消息数
//    if (conversation.unreadMessagesCount) {
//        self.unReadMessage.hidden = NO;
//        NSString *unReadMessage = [NSString stringWithFormat:@"%lu", (unsigned long)conversation.unreadMessagesCount];
//        [self.unReadMessage setTitle:unReadMessage forState:UIControlStateNormal];
//        self.unReadMessage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    } else {
//        
//        self.unReadMessage.hidden = YES;
//    }
    
    
    
    
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageViewX = 15.f;
    CGFloat imageViewY = imageViewX;
    CGFloat imageViewHeight = self.contentView.height - imageViewY * 2;
    CGFloat imageViewWidth = imageViewHeight;
    _myImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    CGFloat labelX = imageViewX + imageViewWidth + 5;
    CGFloat labelWidth = self.contentView.width - labelX - 70;
    CGFloat labelHeight = imageViewHeight / 2;
    _titleLabel.frame = CGRectMake(labelX, imageViewY, labelWidth / 2, labelHeight);
    
    _cententLabel.frame = CGRectMake(labelX, imageViewY + labelHeight, labelWidth, labelHeight);
    
    _timeLabel.frame = CGRectMake(self.contentView.width - 100, imageViewY, 70, 30);

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
