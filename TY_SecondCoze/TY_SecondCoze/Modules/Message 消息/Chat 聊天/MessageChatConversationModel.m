//
//  MessageChatConversationModel.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/28.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageChatConversationModel.h"
#import "NSDate+Categories.h"

@interface MessageChatConversationModel ()

/************** 文字消息 *******************/

// 文字聊天内容
@property (nonatomic, copy) NSString *contentText;

// 文字聊天的背景颜色
@property (nonatomic, strong) UIColor *contentBackGroundColor;


/************** 图片消息 *******************/

// 详情大图
@property (nonatomic, strong) UIImage *contentImage;

// 预览图
@property (nonatomic, strong) UIImage *contentThumbnailImage;

// 详情大图url
@property (nonatomic, strong) NSURL *contentImageURL;

// 预览图
@property (nonatomic, strong) NSURL *contentThumbnailImageURL;

// 预览图尺寸
@property (nonatomic, assign) CGSize contentThumbnailImageSize;

// 是否横预览
@property (nonatomic, assign, getter=isVertical) BOOL vertical;

/************** 语音消息 *******************/

// 持续时间
@property (nonatomic, assign) NSInteger voiceDuration;

// 本地路径
@property (nonatomic, copy) NSString *voicePath;


// 音频图片动态图数组
@property (nonatomic, strong) NSMutableArray *imageArray;


/************** 其他 *******************/

// 头像url
@property (nonatomic, copy) NSString *userIcon;

// timeStr
@property (nonatomic, copy) NSString *timeStr;

// 是我还是他
@property (nonatomic, assign, getter=isMe) BOOL me;

// 消息类型
@property (nonatomic) MessageBodyType messageBodyType;

@end

@implementation MessageChatConversationModel


- (void)setMessage:(EMMessage *)message {
    _message = message;
    
    
    self.imageArray = [NSMutableArray array];
    
    // 是我还是他
    NSString *loginUsername = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    if ([loginUsername isEqualToString:message.from]) {
        self.me = YES;
        self.userIcon = @"head.jpg";
        self.contentBackGroundColor = [UIColor cyanColor];
        
        for (int i = 1; i <= 3 ; i++) {
            NSString *imageName = [NSString stringWithFormat:@"me%d.png", i];
            UIImage *image = [UIImage imageNamed:imageName];
            [self.imageArray addObject:image];
        }
        
    } else if([loginUsername isEqualToString:message.to]){
        self.me = NO;
        self.userIcon = @"head.jpg";
        self.contentBackGroundColor = [UIColor whiteColor];
        
        for (int i = 1; i <= 3 ; i++) {
            NSString *imageName = [NSString stringWithFormat:@"he%d.png", i];
            UIImage *image = [UIImage imageNamed:imageName];
            [self.imageArray addObject:image];
        }
        
    }
    
    
    // 时间戳
    self.timeStr = [NSDate intervalSinceNow:message.timestamp];
    
    
    
    
    
    
    
    // 解析消息
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    
    self.messageBodyType = msgBody.messageBodyType;
    switch (msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            NSLog(@"收到的文字是 txt -- %@",txt);
            
            self.contentText = txt;
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
            NSLog(@"大图的下载状态 -- %lu",(unsigned long)body.attachmentDownloadStatus);
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.localPath]) {
                self.contentImage = [UIImage imageWithContentsOfFile:body.localPath];
            }
            self.contentImageURL = [NSURL URLWithString:body.remotePath];
            
            
            // 缩略图sdk会自动下载
            NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
            NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
            NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
            NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
            NSLog(@"小图的下载状态 -- %lu",(unsigned long)body.thumbnailDownloadStatus);
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.thumbnailLocalPath]) {
                self.contentThumbnailImage = [UIImage imageWithContentsOfFile:body.thumbnailLocalPath];
                
            }
            self.contentThumbnailImageURL = [NSURL URLWithString:body.thumbnailRemotePath];
            
            self.contentThumbnailImageSize = body.thumbnailSize;
            
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
            
            
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.localPath]) {
                self.voicePath = body.localPath;
            }
            self.voiceDuration = body.duration;
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





@end
