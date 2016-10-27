//
//  AddManViewController.h
//  TY_SecondCoze
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQViewController.h"

#warning mark --- 协议第一步
@protocol doSomething <NSObject>

- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message;

@end

@interface AddManViewController : TYQViewController

#warning mark --- 协议第二步
@property (nonatomic, assign) id<doSomething>myDelegate;



@end
