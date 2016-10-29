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

// 头像url
@property (nonatomic, copy, readonly) NSString *photoName;

// timeStr
@property (nonatomic, copy, readonly) NSString *timeStr;

// 是我还是他
@property (nonatomic, assign, getter=isMe, readonly) BOOL me;

// 消息类型
@property (nonatomic, readonly) MessageBodyType messageBodyType;


#pragma mark 文字消息

// 文字聊天内容
@property (nonatomic, copy, readonly) NSString *contentText;




@end
