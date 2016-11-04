//
//  MessageChatConversationModel.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/28.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQModel.h"

@interface MessageChatConversationModel : TYQModel

@property (nonatomic, strong) EMMessage *message;
// 是我还是对方 我为YES
@property (nonatomic, assign) BOOL isMe;

// 消息类型
@property (nonatomic, readonly) MessageBodyType messageBodyType;

/////// 文字消息

@property (nonatomic, copy) NSString *textMessage;

/////// 图片

// 小图url
@property (nonatomic, strong) NSURL *imageUrl;
// 小图本地
@property (nonatomic, strong) UIImage *image;
// 小图尺寸
@property (nonatomic, assign) CGSize imageSize;


// 大图本地
@property (nonatomic, strong) UIImage *strongImage;
// 大图url
@property (nonatomic, strong) NSURL *strongImageUrl;
// 大图尺寸
@property (nonatomic, assign) CGSize strongSize;

/////// 音频

// 声音本地
@property (nonatomic, copy) NSString *voicePath;
// 声音长度
@property (nonatomic, assign) NSInteger voiceDuration;

@end


