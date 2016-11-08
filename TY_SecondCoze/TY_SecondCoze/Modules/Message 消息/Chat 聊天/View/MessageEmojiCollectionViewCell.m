//
//  MessageEmojiCollectionViewCell.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/8.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageEmojiCollectionViewCell.h"

#import "PureLayout.h"

@interface MessageEmojiCollectionViewCell ()


{
    UIImageView *mImageView;
}


@end
@implementation MessageEmojiCollectionViewCell



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        mImageView = [[UIImageView alloc]initForAutoLayout];
        mImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:mImageView];
        
        [mImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [mImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        [mImageView autoSetDimensionsToSize:CGSizeMake(28, 28)];
        
        
    }
    return self;
}

-(void)setModel:(NSDictionary *)model
{
    _model = model;
    
    mImageView.image = [UIImage imageNamed:model[@"image"]];
}










@end
