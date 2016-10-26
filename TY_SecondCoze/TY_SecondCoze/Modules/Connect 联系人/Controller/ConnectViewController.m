//
//  ConnectViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "ConnectViewController.h"

@interface ConnectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
#pragma mark --- 创建collectionview
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDTH - 90) / 3, (WIDTH - 90) / 3);
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, (WIDTH - 90) / 3 + 20) collectionViewLayout:flowLayout];
    _myCollectionView.backgroundColor = [UIColor cyanColor];
    _myCollectionView.contentInset = UIEdgeInsetsMake(10, 20, 10, 20);
    [self.view addSubview:_myCollectionView];
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    
    
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellC"];
    
#pragma mark --- 创建tableview
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    self.myTableView.tableHeaderView = _myCollectionView;
    [self.view addSubview:_myTableView];
    
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellT"];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma collectView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellC" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}


#pragma mark --- tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellT"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
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
