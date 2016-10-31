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

// 图片路径
@property (nonatomic, copy) NSString *imageUrl;


@end


