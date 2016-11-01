//
//  MessageChatConversationModel.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/28.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageChatConversationModel.h"
#import "NSDate+Categories.h"
#import "Tools.h"

@interface MessageChatConversationModel ()

// 消息类型
@property (nonatomic) MessageBodyType messageBodyType;

@end

@implementation MessageChatConversationModel


- (void)setMessage:(EMMessage *)message {
    _message = message;
    
    
    
    // 是我的还是对方的
    NSString *myUsername = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    if ([myUsername isEqualToString:message.from]) {
        self.isMe = YES;
        
    } else if([myUsername isEqualToString:message.to]){
        self.isMe = NO;
        
    }
    
    // 解析消息
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    
    self.messageBodyType = msgBody.messageBodyType;
    switch (msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            self.textMessage = txt;
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
                self.strongImage = [UIImage imageWithContentsOfFile:body.localPath];
            }
            self.strongImageUrl = [NSURL URLWithString:body.remotePath];
            
            // 缩略图sdk会自动下载
            NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
            NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
            NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
            NSLog(@"小图的W -- %f ,小图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
            NSLog(@"小图的下载状态 -- %lu",(unsigned long)body.thumbnailDownloadStatus);
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.thumbnailLocalPath]) {
                self.image = [UIImage imageWithContentsOfFile:body.thumbnailLocalPath];
            }
            self.imageUrl = [NSURL URLWithString:body.remotePath];
            
            CGFloat bubbleTextWidthMax = WIDTH - (10 + 50) * 2 - 15.f * 2;
            CGFloat Width = bubbleTextWidthMax - 40;

            if (body.thumbnailSize.width > body.thumbnailSize.height) {
                
                Width = bubbleTextWidthMax;

            } else {
                
                Width = bubbleTextWidthMax / 4 * 3;
            }
            
            self.imageSize = CGSizeMake(Width, Width / body.thumbnailSize.width * body.thumbnailSize.height);
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
            
            self.voicePath = body.localPath;
            
            self.voiceDuration = body.duration;
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.localPath]) {
            }
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
