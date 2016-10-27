//
//  ConnectViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "ConnectViewController.h"
#import "ConnectCollectionViewCell.h"
#import "ConnectTableViewCell.h"
#import "AddManViewController.h"

#import "NewViewController.h"

#import "FriendDailViewController.h"

@interface ConnectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,EMChatManagerDelegate>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *wordArray;
@end

@implementation ConnectViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

    
    
    self.imageArray = @[@"xin",@"qun",@"an"];
    self.wordArray = @[@"新朋友",@"群聊",@"暗恋"];
    
#pragma mark --- FT
    
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.textColor = [UIColor redColor];
    configuration.tintColor = [UIColor lightGrayColor];
    configuration.borderColor = [UIColor blackColor];
    configuration.borderWidth = 3.0f;

    
    
#pragma mark --- 创建collectionview
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDTH - 90) / 3 - 10, (WIDTH - 90) / 3 - 10);
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, (WIDTH - 90) / 3 + 10) collectionViewLayout:flowLayout];
    _myCollectionView.backgroundColor = [UIColor cyanColor];
    _myCollectionView.contentInset = UIEdgeInsetsMake(10, 20, 10, 20);
    [self.view addSubview:_myCollectionView];
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    
    
    [self.myCollectionView registerClass:[ConnectCollectionViewCell class] forCellWithReuseIdentifier:@"cellC"];
    
#pragma mark --- 创建tableview
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 50) style:UITableViewStyleGrouped];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    self.myTableView.tableHeaderView = _myCollectionView;
    [self.view addSubview:_myTableView];
    
    [self.myTableView registerClass:[ConnectTableViewCell class] forCellReuseIdentifier:@"cellT"];
    
    [self addNavigationBarView];
    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"jia"];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma collectView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellC" forIndexPath:indexPath];
    cell.stringImage = _imageArray[indexPath.row];
    cell.stringWord = _imageArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
       
        NewViewController *newVC = [[NewViewController alloc] init];
        newVC.infoArray = _infoArray;
         newVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newVC animated:YES];
    }
    
}

#pragma mark --- tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellT"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
#pragma mark --- 跳转到联系人详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendDailViewController *fdVC = [FriendDailViewController new];
    fdVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fdVC animated:YES];
}

#pragma mark ---右按钮方法(下拉菜单)
-(void)tyq_navigationBarViewRightButtonAction{
    
    [FTPopOverMenu showForSender:self.navigationBarView.rightButton withMenu:@[@"添加联系人",@"添加群",@"随意 "] doneBlock:^(NSInteger selectedIndex) {
        
        if (selectedIndex == 0) {
            
            AddManViewController *addVC = [AddManViewController new];
         
            [self.navigationController pushViewController:addVC animated:YES];
            
        }
        if (selectedIndex == 1) {
            
            NSLog(@"添加群");
        }
        if (selectedIndex == 2) {
            
            NSLog(@"随意");
        }
        
    } dismissBlock:^{
        
        NSLog(@"dismiss");
        
    }];
    
    
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
