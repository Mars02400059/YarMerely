//
//  ConnectAddGroupViewController.h
//  TY_SecondCoze
//
//  Created by mars on 16/11/8.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQViewController.h"

@protocol ConnectAddGroupViewControllerDelegate <NSObject>

- (void)tyq_dismiss;

@end

@interface ConnectAddGroupViewController : TYQViewController

@property (nonatomic, strong) NSArray *tableViewArray;

@property (nonatomic, assign) id<ConnectAddGroupViewControllerDelegate>delegate;

@end
