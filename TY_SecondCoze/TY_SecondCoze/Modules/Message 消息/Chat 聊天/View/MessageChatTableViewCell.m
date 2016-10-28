//
//  MessageChatTableViewCell.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/28.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageChatTableViewCell.h"

@interface MessageChatTableViewCell ()

@property (nonatomic, strong) TYQLabel *mylabel;

@end

@implementation MessageChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.mylabel = [[TYQLabel alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_mylabel];
    }
    return self;
}

- (void)setMessage:(EMMessage *)message {
    _message = message;
    
    NSLog(@"%@", message.messageBodies);
    NSArray *array = message.messageBodies;
    for (NSDictionary *dic in array) {
        _mylabel.text = [dic objectForKey:@"msg"];
    }
//    _mylabel.text = message.messageBodies[0];
    
}



@end
