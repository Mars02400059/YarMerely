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
// 文字消息
@property (nonatomic, strong) TYQLabel *mylabel;



@end

@implementation MessageChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.iconButton = [TYQButton buttonWithType:UIButtonTypeCustom];
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
        [self.contentView addSubview:_iconButton];
        
        self.bubbleView = [[BubbleView alloc] init];
        _bubbleView.numberOfLines = 0;
        _bubbleView.font = 20;
        [self.contentView addSubview:_bubbleView];
        
        
        self.mylabel = [[TYQLabel alloc] initWithFrame:self.contentView.bounds];
        _mylabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_mylabel];
    }
    return self;
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
- (void)setChatModel:(MessageChatConversationModel *)chatModel {
    
    
    _chatModel = chatModel;
    
    
    _bubbleView.title = chatModel.textMessage;
    
    
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
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            _mylabel.text = txt;
        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
            NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用SDK提供的下载方法后才会存在
            NSLog(@"大图的secret -- %@"    ,body.secretKey);
            NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
            NSLog(@"大图的下载状态 -- %lu",body.attachmentDownloadStatus);
            
            
            // 缩略图sdk会自动下载
            NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
            NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
            NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
            NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
            NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
        }
            break;
        case eMessageBodyType_Location:
        {
            EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
            NSLog(@"纬度-- %f",body.latitude);
            NSLog(@"经度-- %f",body.longitude);
            NSLog(@"地址-- %@",body.address);
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频SDK会自动下载
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在（音频会自动调用）
            NSLog(@"音频的secret -- %@"        ,body.secretKey);
            NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"音频文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
            NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
        }
            break;
        case eMessageBodyType_Video:
        {
            EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
            
            NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在
            NSLog(@"视频的secret -- %@"        ,body.secretKey);
            NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"视频文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
            NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
            NSLog(@"视频的W -- %f ,视频的H -- %f", body.size.width, body.size.height);
            
            // 缩略图sdk会自动下载
            NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
            NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailRemotePath);
            NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
            NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
        }
            break;
        case eMessageBodyType_File:
        {
            EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
            NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
            NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在
            NSLog(@"文件的secret -- %@"        ,body.secretKey);
            NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"文件文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
        }
            break;
            
        default:
            break;
    }
    

}

#endif

@end
