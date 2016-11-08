//
//  NewViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "NewViewController.h"
#import "AddManViewController.h"
#import "InfoModel.h"
#import "ConnectNewTableviewCell.h"
#import "ConnetMessageViewController.h"
@interface NewViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
ConnetMessageViewControllerDelegate
>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) TYQLabel *label;

@end

@implementation NewViewController

-(void)viewDidAppear:(BOOL)animated{
    
    [_myTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
#pragma mark --- 创建tableview
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    
    [self.myTableView registerClass:[ConnectNewTableviewCell class] forCellReuseIdentifier:@"cell"];
    
    
     [self addNavigationBarView];
     self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    self.navigationBarView.title = @"新朋友";
    
      // Do any additional setup after loading the view.
}
#pragma mark ---返回
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma tableView dataSouce
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectNewTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.infoModel = _infoArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnetMessageViewController *messageVC = [ConnetMessageViewController new];
    messageVC.delegate = self;
    InfoModel *model = _infoArray[indexPath.row];
    
    messageVC.infoModelMessage = model;
    
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)tyq_agreeButtonActionDelegate {
    /// 改变好友申请的数据, 刷新本VCtableview, 写不出来就不写了
    
    [self.delegare tyq_change];
    
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
