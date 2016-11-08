//
//  MineImageTableViewCell.h
//  TY_SecondCoze
//
//  Created by mars on 16/10/25.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQTableViewCell.h"

@interface MineImageTableViewCell : TYQTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (nonatomic, copy) NSString *title;

@end
