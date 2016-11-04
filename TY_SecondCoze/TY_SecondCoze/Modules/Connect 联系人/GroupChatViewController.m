//
//  GroupChatViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/4.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupChatViewController.h"
#import "GroupMemberViewController.h"
@interface GroupChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation GroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     群聊页面
     */
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"群"];
    
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --- DataSource, Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

//左按钮

-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//右按钮

-(void)tyq_navigationBarViewRightButtonAction{
    
    GroupMemberViewController *memberVC = [[GroupMemberViewController alloc] init];
    
    [self.navigationController pushViewController:memberVC animated:YES];
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
