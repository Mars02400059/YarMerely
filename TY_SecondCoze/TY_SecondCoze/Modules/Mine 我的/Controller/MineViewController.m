//
//  MineViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineViewController.h"

static NSString *const cellIdetifeir = @"cell";

@interface MineViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
/// 头视图
@property (nonatomic, strong) TYQView *headView;
/// 用户头像
@property (nonatomic, strong) TYQImageView *userHeadPortraits;
/// 用户名
@property (nonatomic, strong) TYQLabel *userNameLabel;
/// 头视图背景图片
@property (nonatomic, strong) TYQImageView *headBackImageView;
/// 头视图背景图片宽度
@property (nonatomic, assign) CGFloat headBackImageViewWidth;
/// 头视图背景图片高度
@property (nonatomic, assign) CGFloat headBackImageViewHeight;



@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addSubsView];

    
    [self addNavigationBarView];
    self.navigationBarView.backColor.alpha = 0.f;
    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"设置"];
}

- (void)addSubsView {
    
    self.headBackImageView = [[TYQImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    _headBackImageView.userInteractionEnabled = YES;
    _headBackImageView.frame = CGRectMake(0, 0, WIDTH, WIDTH * 0.7);
    self.headBackImageViewWidth = _headBackImageView.width;
    self.headBackImageViewHeight = _headBackImageView.height;
    [self.view addSubview:_headBackImageView];

    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdetifeir];
    [self.view addSubview:_tableView];

    
    
    self.headView = [[TYQView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 0.7)];
    _headView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _headView;
    
    self.userHeadPortraits = [[TYQImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    _userHeadPortraits.backgroundColor = [UIColor whiteColor];
    _userHeadPortraits.frame = CGRectMake((_headView.width - 80) / 2, _headView.height - 130, 80, 80);
    _userHeadPortraits.layer.cornerRadius = _userHeadPortraits.width / 2;
    [_headView addSubview:_userHeadPortraits];
    
    self.userNameLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(0, _headView.height - 35, WIDTH, 20)];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.text = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    _userNameLabel.font = [UIFont systemFontOfSize:19.f];
    _userNameLabel.textColor = [UIColor whiteColor];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    [_headView addSubview:_userNameLabel];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifeir];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if (scrollView.contentOffset.y < 100) {
        self.navigationBarView.backColor.alpha = scrollView.contentOffset.y / 100;
        
    } else {
        self.navigationBarView.backColor.alpha = 1.f;
    }
    
    if (scrollView.contentOffset.y < 0) {
        
        CGFloat headImageViewHeight = _headBackImageViewHeight - scrollView.contentOffset.y;
        CGFloat headImageViewWidth = _headBackImageViewWidth * headImageViewHeight / _headBackImageViewHeight;
        CGFloat headImageViewX = (_headBackImageViewWidth - headImageViewWidth) / 2;
        CGFloat headImageViewY = 0;
        _headBackImageView.frame = CGRectMake(headImageViewX, headImageViewY, headImageViewWidth, headImageViewHeight);
        
    } else {
        
        CGFloat headImageViewY = -scrollView.contentOffset.y;
        _headBackImageView.frame = CGRectMake(0, headImageViewY, _headBackImageViewWidth, _headBackImageViewHeight);
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
