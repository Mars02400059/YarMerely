//
//  MessageChatFrameModel.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/29.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQModel.h"
@class MessageChatConversationModel;

@interface MessageChatFrameModel : TYQModel


@property(nonatomic, strong) MessageChatConversationModel *conversation;

// timeLab
@property(nonatomic, assign, readonly) CGRect timeFrame;
// 头像
@property(nonatomic, assign, readonly) CGRect iconFrame;
// 内容
@property(nonatomic, assign, readonly) CGRect contentFrame;
// cell高度
@property(nonatomic, assign, readonly) CGFloat cellH;


@end
