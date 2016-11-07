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
#import "GroupAddViewController.h"
#import "GroupViewController.h"
#import "NewViewController.h"

#import "GroupMixViewController.h"

#import "FriendDailViewController.h"

@interface ConnectViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
EMChatManagerDelegate,
NewViewControllerDelegate
>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *wordArray;

@property (nonatomic, strong) NSArray *listArray;
@end

@implementation ConnectViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [_myTableView reloadData];
    
}

- (NSArray *)listArray {
    
    if (nil == _listArray) {
        EMError *error = nil;
        NSArray *buddyList = [[EaseMob sharedInstance].chatManager fetchBuddyListWithError:&error];
        if (!error) {
            _listArray = buddyList;
        }
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     self.title = @"联系人"
     */
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    


    self.imageArray = @[@"xin",@"qun",@"an"];
    self.wordArray = @[@"新朋友",@"群聊",@"暗恋"];
    
#pragma mark --- FT
    
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.textColor = [UIColor whiteColor];
    configuration.tintColor = [UIColor lightGrayColor];
    configuration.borderColor = [UIColor blackColor];
    configuration.borderWidth = 1.0f;

    
    
#pragma mark --- 创建collectionview
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDTH - 90) / 3 - 10, (WIDTH - 90) / 3 - 10);
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, (WIDTH - 90) / 3 + 10) collectionViewLayout:flowLayout];
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    _myCollectionView.contentInset = UIEdgeInsetsMake(10, 20, 10, 20);
    [self.view addSubview:_myCollectionView];
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    
    
    [self.myCollectionView registerClass:[ConnectCollectionViewCell class] forCellWithReuseIdentifier:@"cellC"];
    
#pragma mark --- 创建tableview
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 50) style:UITableViewStylePlain];
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
    cell.stringWord = _wordArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
       
        NewViewController *newVC = [[NewViewController alloc] init];
        newVC.infoArray = _infoArray;
        newVC.delegare = self;
         newVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newVC animated:YES];
    }
    if (indexPath.item == 1) {
        
        GroupViewController *groupVC = [[GroupViewController alloc] init];
        
        [self.navigationController pushViewController:groupVC animated:YES];
        
    }
    
    return;
}

#pragma mark -- 同意好友申请 ,刷新好友列表

- (void)tyq_change {
    
    EMError *error = nil;
    NSArray *buddyList = [[EaseMob sharedInstance].chatManager fetchBuddyListWithError:&error];
    if (!error) {
        self.listArray = buddyList;
        [_myTableView reloadData];
    }

}


#pragma mark --- tableview datasource

#if 1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return self.listArray.count;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellT"];
    
    cell.infoModel = self.listArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
#pragma mark --- 跳转到联系人详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendDailViewController *fdVC = [FriendDailViewController new];
    fdVC.infoModel = _listArray[indexPath.row];
    fdVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fdVC animated:YES];
}

#endif
#pragma mark ---右按钮方法(下拉菜单)
-(void)tyq_navigationBarViewRightButtonAction{
    
    [FTPopOverMenu showForSender:self.navigationBarView.rightButton withMenu:@[@"添加联系人",@"创建群",@"个人主动加入群"] doneBlock:^(NSInteger selectedIndex) {
        
        if (selectedIndex == 0) {
            
            AddManViewController *addVC = [AddManViewController new];
         
            [self.navigationController pushViewController:addVC animated:YES];
            
        }
        if (selectedIndex == 1) {
            //创建群
            GroupAddViewController *groupVC = [[GroupAddViewController alloc] init];
            
            [self.navigationController pushViewController:groupVC animated:YES];

        }
        if (selectedIndex == 2) {
            
            GroupMixViewController *mixVC = [[GroupMixViewController alloc] init];
            
            [self.navigationController pushViewController:mixVC animated:YES];
            
//            NSLog(@"个人主动加入");
        }
        
    } dismissBlock:^{
        
        NSLog(@"dismiss");
        
    }];
    
    
}








#pragma mark --- 调取SDK接受好友请求方法(回调)
-(void)didAcceptedByBuddy:(NSString *)username{
    
 
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ 接受了你的请求", username] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = nil;
        NSArray *buddyList = [[EaseMob sharedInstance].chatManager fetchBuddyListWithError:&error];
        if (!error) {
            self.listArray = buddyList;
            [_myTableView reloadData];
        }
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
    //    InfoModel *infoModel = [[InfoModel alloc] init];
    //     infoModel.username = username;
    
}
#pragma mark --- 调取SDK拒绝好友请求(回调)
- (void)didRejectedByBuddy:(NSString *)username{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ 拒绝了你的请求", username] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    //    InfoModel *infoModel = [[InfoModel alloc] init];
    //    infoModel.username = username;
    
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
