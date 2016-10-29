//
//  MessageChatViewController.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQViewController.h"
#import "InfoModel.h"

@interface MessageChatViewController : TYQViewController

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, strong) InfoModel *infoModel;

@end
