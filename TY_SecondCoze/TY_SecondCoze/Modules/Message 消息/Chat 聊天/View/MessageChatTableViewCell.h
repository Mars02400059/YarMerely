//
//  MessageChatTableViewCell.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/28.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQTableViewCell.h"
@class MessageChatConversationModel;
@class MessageChatTableViewCell;
// 左边好友的Cell

@protocol MessageChatTableViewCellDelegate <NSObject>

- (void)tyq_bubbleTapGestureRecognizerTableViewCell:(MessageChatTableViewCell *)messageChatTableViewCell;

@end

@interface MessageChatTableViewCell : TYQTableViewCell

/// 聊天类型 : 1 为单聊 , 2 为群聊
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) MessageChatConversationModel *chatModel;

@property (nonatomic, assign) id<MessageChatTableViewCellDelegate>delegate;


@end
