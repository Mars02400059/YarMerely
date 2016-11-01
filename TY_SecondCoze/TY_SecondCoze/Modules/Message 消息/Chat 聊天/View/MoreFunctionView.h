//
//  MoreFunctionView.h
//  TY_SecondCoze
//
//  Created by mars on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQView.h"

@protocol MoreFunctionViewDelegate <NSObject>

- (void)tyq_addPhotoActionDelegate;

@end

@interface MoreFunctionView : TYQView

@property (nonatomic, strong) TYQButton *photoButton;

@property (nonatomic, assign) id<MoreFunctionViewDelegate>delegate;

@end
