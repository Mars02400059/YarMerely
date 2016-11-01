//
//  MessageChatTableViewCell.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/28.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageChatTableViewCell.h"
#import "MessageChatConversationModel.h"
#import "Tools.h"
#import "BubbleView.h"

@interface MessageChatTableViewCell ()

@property (nonatomic, assign) BOOL isMe;
// 头像
@property (nonatomic, strong) TYQButton *iconButton;
// 消息气泡
@property (nonatomic, strong) BubbleView *bubbleView;



@end

@implementation MessageChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.iconButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
        [self.contentView addSubview:_iconButton];
        
        self.bubbleView = [[BubbleView alloc] initWithFrame:CGRectZero];
        _bubbleView.numberOfLines = 0;
        _bubbleView.font = 20;
        [self.contentView addSubview:_bubbleView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_bubbleView addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}
#pragma mark - 气泡的轻拍手势
- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self.delegate tyq_bubbleTapGestureRecognizerTableViewCell:self];
}

#pragma mark - 自适应气泡
- (void)setSubsViewFrame:(BOOL)isMe {
    
    
    CGFloat iconX;
    CGFloat iconWidth = 50.f;
    CGFloat iconHeight = iconWidth;
    
    if (isMe == NO) {
        iconX = 10.f;
        
    } else {
        iconX = WIDTH - 10 - iconWidth;
        
    }
    
    CGFloat iconY = 10.f;
    
    
    _iconButton.frame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    switch (_chatModel.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            CGFloat bubbleX;
            CGFloat bubbleY = iconY;
            CGFloat bubbleWidth;
            CGFloat bubbleHeight;
            CGFloat border = 15.f;
            CGFloat bubbleTextWidthMax = WIDTH - (10 * 2 + iconWidth) * 2 - border * 2;
            
            CGFloat bubbleTextWidth;
            CGFloat bubbleTextHeight;
            CGFloat textWidth = [Tools getTextWidth:_chatModel.textMessage withFontSize:20.f];
            if (textWidth < bubbleTextWidthMax) {
                bubbleTextWidth = textWidth;
                bubbleTextHeight = 22.f;
                
                
            } else {
                CGFloat textHeight = [Tools getTextHeight:_chatModel.textMessage withWidth:bubbleTextWidthMax withFontSize:20];
                bubbleTextWidth = bubbleTextWidthMax;
                bubbleTextHeight = textHeight;
            }
            bubbleWidth = bubbleTextWidth + border * 2;
            bubbleHeight = bubbleTextHeight + border * 2;
            
            if (isMe == NO) {
                bubbleX = iconX + iconWidth + 10.f;
            } else {
                bubbleX = iconX - 10 - bubbleWidth;
            }
            _bubbleView.isLeft = isMe;
            
            _bubbleView.frame = CGRectMake(bubbleX, bubbleY, bubbleWidth, bubbleHeight);

        }
            break;
        case eMessageBodyType_Image:
        {
            
            CGFloat imageX;
            CGFloat imageY = iconY;
            CGFloat imageWidth = _chatModel.imageSize.width;
            CGFloat imageHeight = _chatModel.imageSize.height;
//            imageWidth = WIDTH / 2;
//            imageHeight = imageWidth * 1.2;
            if (isMe == NO) {
                imageX = iconX + iconWidth + 10.f;
            } else {
                imageX = iconX - 10 - _chatModel.imageSize.width;
            }
            
            // 得到一个图片消息body
            _bubbleView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
        }
            break;
        case eMessageBodyType_Location:
        {
            // 经纬度
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频SDK会自动下载
            
            CGFloat bubbleX;
            CGFloat bubbleY = iconY;
            CGFloat bubbleWidth;
            CGFloat bubbleHeight = 50.f;
            CGFloat border = 0.5f;
            
            if (_chatModel.voiceDuration > 50) {
                bubbleWidth = 60 + 50 * border;
            } else if (_chatModel.voiceDuration <= 50 && _chatModel.voiceDuration > 5) {
                bubbleWidth = 60 + (CGFloat)(_chatModel.voiceDuration - 5) * border;

            } else {
                bubbleWidth = 60;
            }
            
            if (isMe == NO) {
                bubbleX = iconX + iconWidth + 10.f;
            } else {
                bubbleX = iconX - 10 - bubbleWidth;
            }
            _bubbleView.isLeft = isMe;
            
            _bubbleView.frame = CGRectMake(bubbleX, bubbleY, bubbleWidth, bubbleHeight);
            

            
        }
            break;
        case eMessageBodyType_Video:
        {
            // 视频
            
        }
            break;
        case eMessageBodyType_File:
        {
            // 文件
        }
            break;
            
        default:
            break;
    }

    
    
    
    
}
- (void)setChatModel:(MessageChatConversationModel *)chatModel {
    

    
    _chatModel = chatModel;
    
    
    
    
    switch (chatModel.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            _bubbleView.title = chatModel.textMessage;

        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            if (chatModel.image) {
                _bubbleView.chatImageView.image = chatModel.image;
            } else {
                
                [_bubbleView.chatImageView sd_setImageWithURL:chatModel.imageUrl];
            }

        }
            break;
        case eMessageBodyType_Location:
        {
            // 经纬度
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频SDK会自动下载
            _bubbleView.title = @"点我播放";

        }
            break;
        case eMessageBodyType_Video:
        {
            // 视频
            
        }
            break;
        case eMessageBodyType_File:
        {
            // 文件
        }
            break;
            
        default:
            break;
    }

    
    [self setSubsViewFrame:chatModel.isMe];
    
    
}

#if 0

- (void)setMessage:(EMMessage *)message {
    _message = message;
    
    
    // 是我还是他
    NSString *loginUsername = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    if ([loginUsername isEqualToString:message.from]) {
        self.isMe = YES;
        
        
    } else if([loginUsername isEqualToString:message.to]){
        self.isMe = NO;
        
        
        
    }
    
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch (msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            
        }
            break;
        case eMessageBodyType_Location:
        {
            // 经纬度
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频SDK会自动下载
            
        }
            break;
        case eMessageBodyType_Video:
        {
            // 视频
           
        }
            break;
        case eMessageBodyType_File:
        {
           // 文件
        }
            break;
            
        default:
            break;
    }
    

}

#endif

@end
