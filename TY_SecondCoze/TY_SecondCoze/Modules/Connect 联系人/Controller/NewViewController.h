//
//  NewViewController.h
//  TY_SecondCoze
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQViewController.h"

@protocol NewViewControllerDelegate <NSObject>

- (void)tyq_change;

@end

@interface NewViewController : TYQViewController

@property (nonatomic, strong) NSArray *infoArray;

@property (nonatomic, assign) id<NewViewControllerDelegate>delegare;

@end
