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
#import "MessageChatViewController.h"
#import "MineInfoViewController.h"
#import "MineSpeakViewController.h"


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
    
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.000];
    
    self.dataSouce = @[@"",@"详细资料",@"说过的话"];
    
#pragma mark --- 创建tableview
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT / 2) style:UITableViewStyleGrouped];;
    _myTableView.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.000];
    _myTableView.scrollEnabled = NO;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    
    self.headerView = [[TYQView alloc] initWithFrame:CGRectMake(0, 0, WIDTH , 120)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _myTableView.tableHeaderView = _headerView;
    [self.view addSubview:_myTableView];
    
#pragma mark --- 注册cell
     [_myTableView registerNib:[UINib nibWithNibName:@"MineGrayBackTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellI"];
     [_myTableView registerNib:[UINib nibWithNibName:@"MineImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellG"];
    
    //头式图上头像和个性签名和昵称
    self.headImageV = [[TYQImageView alloc] initWithFrame:CGRectMake(20, 20, self.headerView.frame.size.height - 40, self.headerView.frame.size.height - 40)];
    _headImageV.layer.cornerRadius = 10;
    _headImageV.layer.masksToBounds = YES;
    
    self.nickNameLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(_headImageV.frame.origin.x + _headImageV.frame.size.width + 10, _headImageV.frame.origin.y, WIDTH / 2, 25)];
    _nickNameLabel.backgroundColor = [UIColor clearColor];
    
    self.qqLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(_nickNameLabel.frame.origin.x , _headImageV.y + _headImageV.height - 50, WIDTH / 3 * 2, 50)];
    _qqLabel.backgroundColor = [UIColor clearColor];

    [self.headerView addSubview:_qqLabel];
    [self.headerView addSubview:_nickNameLabel];
    [self.headerView addSubview:_headImageV];
    
#pragma mark --- 开始聊天按钮
    self.chatButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _chatButton.backgroundColor = [UIColor colorWithRed:0.39 green:0.78 blue:0.55 alpha:1.000];
    _chatButton.frame = CGRectMake(25, _myTableView.frame.origin.y + _myTableView.frame.size.height + 20, WIDTH - 50, 55);
    _chatButton.layer.cornerRadius = 8.f;
    _chatButton.layer.masksToBounds = YES;
    [_chatButton setTitle:@"开始聊天" forState:UIControlStateNormal];
    [self.view addSubview:_chatButton];
    [_chatButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
#pragma mark --- 假导航上的按钮
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    [self getControllerInfo];
    
    // Do any additional setup after loading the view.
}

/// 资料赋值
- (void)getControllerInfo {
    
    /// 获取指定资料
    BmobFile *file = [_object objectForKey:@"photoFile"];
    /// 头像
    [_headImageV sd_setImageWithURL:[NSURL URLWithString:file.url]];
    /// 昵称
    _nickNameLabel.text = [NSString stringWithFormat:@"昵称 : %@", [_object objectForKey:@"nickname"]];
    /// 签名
    _qqLabel.text = [NSString stringWithFormat:@"签名 : %@", [_object objectForKey:@"autograph"]];
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
        cell.title = _dataSouce[indexPath.row];
        
        return cell;
    }
    
    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        MineInfoViewController *infoVC = [[MineInfoViewController alloc] init];
        infoVC.accountnumber = [_object objectForKey:@"accountnumber"];
        [self.navigationController pushViewController:infoVC animated:YES];
        
    }
    if (indexPath.row == 2) {
        MineSpeakViewController *speakVC = [[MineSpeakViewController alloc] init];
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"Speak"];
        // 添加playerName不是小明的约束条件
        [bquery whereKey:@"accountnumber" equalTo:[_object objectForKey:@"accountnumber"]];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            NSLog(@"%@", array);
            speakVC.tableViewArrray = array;
            speakVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:speakVC animated:YES];
        }];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 20.f;
    }
    if (indexPath.row == 1 || indexPath.row == 2) {
        
        return 70.f;
    }
        return 100;
}

#pragma mark --- 点击开始聊天,进入消息界面
-(void) buttonAction:(TYQButton *)button{
    
    MessageChatViewController *messVC = [[MessageChatViewController alloc] init];
#warning 需要改成云存储的对象
    messVC.titleName = [_object objectForKey:@"accountnumber"];
    
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
