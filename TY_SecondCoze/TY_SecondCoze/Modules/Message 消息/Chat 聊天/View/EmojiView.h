//
//  EmojiView.h
//  888
//
//  Created by dllo on 16/11/8.
//  Copyright © 2016年 杨志. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 点击图片到textfiled框内哦
 */

@protocol doIt <NSObject>

-(void)doSomething:(NSString *)string;


@end

@interface EmojiView : UIView


@property (nonatomic, assign)id<doIt>delegate;


@end
