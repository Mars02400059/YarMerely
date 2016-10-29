//
//  FriendDailViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/26.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "FriendDailViewController.h"
#import "MineImageTableViewCell.h"
#import "MineGrayBackTableViewCell.h"
#import "MessageViewController.h"

@interface FriendDailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) TYQView *headerView;

@property (nonatomic, strong) TYQImageView *headImageV;
@property (nonatomic, strong) TYQLabel *nickNameLabel;
@property (nonatomic, strong) TYQLabel *qqLabel;

@property (nonatomic, strong) NSArray *dataSouce;

@property (nonatomic, strong) TYQButton *chatButton;

@end

@implementation FriendDailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSouce = @[@"",@"备注>",@"标题2"];
    
#pragma mark --- 创建tableview
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT / 2) style:UITableViewStyleGrouped];;
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.scrollEnabled = NO;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    
    self.headerView = [[TYQView alloc] initWithFrame:CGRectMake(0, 0, WIDTH , 120)];
    _headerView.backgroundColor = [UIColor lightGrayColor];
    _myTableView.tableHeaderView = _headerView;
    [self.view addSubview:_myTableView];
    
#pragma mark --- 注册cell
     [_myTableView registerNib:[UINib nibWithNibName:@"MineGrayBackTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellI"];
     [_myTableView registerNib:[UINib nibWithNibName:@"MineImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellG"];
    
    //头式图上头像和个性签名和昵称
    self.headImageV = [[TYQImageView alloc] initWithFrame:CGRectMake(20, 20, self.headerView.frame.size.height - 40, self.headerView.frame.size.height - 40)];
    _headImageV.layer.cornerRadius = 10;
    _headImageV.layer.masksToBounds = YES;
    self.headImageV.backgroundColor = [UIColor redColor];
    
    self.nickNameLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(_headImageV.frame.origin.x + _headImageV.frame.size.width + 10, _headImageV.frame.origin.y, WIDTH / 3, _headImageV.frame.size.height / 2 - 10)];
    self.nickNameLabel.backgroundColor = [UIColor blueColor];
    
    self.qqLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(_nickNameLabel.frame.origin.x , _nickNameLabel.frame.size.height + _nickNameLabel.frame.origin.y + 5, WIDTH / 3 * 2, _headImageV.frame.size.height / 2)];
    _qqLabel.backgroundColor = [UIColor magentaColor];
    
    [self.headerView addSubview:_qqLabel];
    [self.headerView addSubview:_nickNameLabel];
    [self.headerView addSubview:_headImageV];
    
#pragma mark --- 开始聊天按钮
    self.chatButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _chatButton.backgroundColor = [UIColor greenColor];
    _chatButton.frame = CGRectMake(WIDTH / 4, _myTableView.frame.origin.y + _myTableView.frame.size.height + 50, WIDTH - WIDTH / 2, 50);
    _chatButton.layer.cornerRadius = 10;
    _chatButton.layer.masksToBounds = YES;
    [_chatButton setTitle:@"开始聊天" forState:UIControlStateNormal];
    [self.view addSubview:_chatButton];
    [_chatButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
#pragma mark --- 假导航上的按钮
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --- 左按钮方法
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- tableview datasouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        MineGrayBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellI"];
        
        return cell;
    }
    if (indexPath.row == 1 || indexPath.row == 2) {
        
        MineImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellG"];
        
        if (indexPath.row == 1) {
            
            cell.title = @"标题";
        }if (indexPath.row == 2) {
            
            cell.title = @"备注";
        }

        return cell;
    }
    
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 50.f;
    }if (indexPath.row == 1 || indexPath.row == 2) {
        
        return 70.f;
    }
        return 100;
}

#pragma mark --- 点击开始聊天,进入消息界面
-(void) buttonAction:(TYQButton *)button{
    
    MessageViewController *messVC = [[MessageViewController alloc] init];
    
    [self.navigationController pushViewController:messVC animated:YES];
}




#pragma park --- 键盘回收
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
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
