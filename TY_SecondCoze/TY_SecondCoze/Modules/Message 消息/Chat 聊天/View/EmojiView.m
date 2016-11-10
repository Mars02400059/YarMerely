//
//  EmojiView.m
//  888
//
//  Created by dllo on 16/11/8.
//  Copyright © 2016年 杨志. All rights reserved.
//

#import "EmojiView.h"

#import "MessageEmojiCollectionViewCell.h"

#import <PureLayout.h>




#define kHeightFaceView     (170)

#define kBkColorSendBtn      ([UIColor colorWithRed:0.090 green:0.490 blue:0.976 alpha:1])

//表情个数
#define kFaceNum             (141)
//可重用ID
#define kReuseID             (@"unique")

#define kHeightBtn           (30)

#define kUnSelectedColorPageControl   ([UIColor colorWithRed:0.604 green:0.608 blue:0.616 alpha:1])
#define kSelectedColorPageControl     ([UIColor colorWithRed:0.380 green:0.416 blue:0.463 alpha:1])


@interface EmojiView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *mCollectionView;
    
    UIPageControl    *mPageControl;
}

@property (nonatomic, strong) NSArray *DataSource;

@end

@implementation EmojiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self doSomething];
    }
    return self;
}


-(void) doSomething{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    [layout setItemSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/7-10, (kHeightFaceView - kHeightBtn) / 3  - 15)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.sectionInset = UIEdgeInsetsMake(6,6,6, 6);
    
    mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    mCollectionView.pagingEnabled = YES;
    mCollectionView.showsHorizontalScrollIndicator = NO;
    mCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    mCollectionView.backgroundColor = [UIColor clearColor];
    mCollectionView.dataSource = self;
    mCollectionView.delegate   = self;

    [mCollectionView registerClass:[MessageEmojiCollectionViewCell class] forCellWithReuseIdentifier:kReuseID];
    
    [self addSubview:mCollectionView];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0,0, 0);
    
    [mCollectionView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeBottom];

    
    /**
     *  @brief  最近按钮
     */
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [historyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    historyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    historyBtn.backgroundColor = [UIColor clearColor];
    [historyBtn setImage:[UIImage imageNamed:@"qvip_emoji_tab_history"] forState:UIControlStateNormal];
//    [historyBtn  setImage:[UIImage imageNamed:@"qvip_emoji_tab_history_pressed"] forState:UIControlStateSelected];
    
    [self addSubview:historyBtn];
    [historyBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:mCollectionView withOffset:20];
    [historyBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [historyBtn  autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    
    
    /**
     *  @brief  经典按钮
     */
    UIButton *classicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [classicBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    classicBtn.translatesAutoresizingMaskIntoConstraints = NO;
    classicBtn.backgroundColor = [UIColor clearColor];
    [classicBtn setImage:[UIImage imageNamed:@"qvip_emoji_tab_classic"] forState:UIControlStateNormal];
//    [classicBtn  setImage:[UIImage imageNamed:@"qvip_emoji_tab_classic_pressed"] forState:UIControlStateSelected];
    
    [self addSubview:classicBtn];
    [classicBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:historyBtn];
    [classicBtn  autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [classicBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:historyBtn];
    [classicBtn  autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:historyBtn];
    
    
    /**
     *  @brief  大表情
     */
    UIButton *storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    storeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    storeBtn.backgroundColor = [UIColor clearColor];
    [storeBtn setImage:[UIImage imageNamed:@"qvip_emoji_tab_store"] forState:UIControlStateNormal];
//    [storeBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateNormal];
    
    [self addSubview:storeBtn];
    [storeBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:classicBtn];
    [storeBtn  autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [storeBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:historyBtn];
    [storeBtn  autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:historyBtn];
    
    
    /**
     *  @brief  发送按钮
     */
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    sendBtn.translatesAutoresizingMaskIntoConstraints = NO;
    sendBtn.backgroundColor = kBkColorSendBtn;
    
    [self addSubview:sendBtn];
    [sendBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:storeBtn];
    [sendBtn  autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [sendBtn  autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [sendBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:historyBtn];
    [sendBtn  autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:historyBtn];
    
    
    
    
    /**
     *  @brief  增加PageControl
     */
    mPageControl = [[UIPageControl alloc]initForAutoLayout];
    mPageControl.numberOfPages = kFaceNum/(3*7) +1;
    mPageControl.userInteractionEnabled = NO;
    mPageControl.backgroundColor = [UIColor clearColor];
    mPageControl.currentPage  = 0;
    mPageControl.currentPageIndicatorTintColor = kSelectedColorPageControl;
    mPageControl.pageIndicatorTintColor  = kUnSelectedColorPageControl;
    
    [self addSubview:mPageControl];
    
    [mPageControl autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [mPageControl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:mCollectionView withOffset:-4];
    
}



#pragma mark - UICollectionView Delegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"^^^^^^^^^^^^^^%lu",(unsigned long)self.DataSource.count);
    return self.DataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageEmojiCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseID forIndexPath:indexPath];

    cell.model = self.DataSource[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中了：%ld",(long)indexPath.row);
    
    NSDictionary *dicModel = self.DataSource[indexPath.row];
    NSString *string = dicModel[@"image"];
    [self.delegate doSomething:string];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    mPageControl.currentPage = (scrollView.contentOffset.x)/scrollView.bounds.size.width;
 
}



-(void)btnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


-(NSArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:kFaceNum+8];
    
    int del = 0;
    for (int i=1; i<=kFaceNum; i++)
    {
        if(!((i+del)%(3*7)))
        {//增加删除按键
            del ++;
            [mutableArray addObject:@{@"image":@"aio_face_delete"}];
        }
        
        [mutableArray addObject:@{@"image":[NSString stringWithFormat:@"%03d",i]}];
    }
    
    _DataSource = mutableArray;
    
    return _DataSource;
}


-(CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kHeightFaceView);
}





@end
