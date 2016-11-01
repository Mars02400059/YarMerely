//
//  PhoneButton.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "PhoneButton.h"

@interface PhoneButton ()



@end


@implementation PhoneButton




//触发事件开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.delegate tyq_touchesBegan];
    
}
//触发事件移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
//触发事件结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.delegate tyq_touchesEnded];
    
}
//触发事件被打断
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
