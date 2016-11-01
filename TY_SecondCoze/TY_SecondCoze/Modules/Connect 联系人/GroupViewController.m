//
//  GroupViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     显示的群的列表
     */
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    
//注册tableview
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self addNavigationBarView];
  self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --- 左按钮返回
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- tableview的datasouce.delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
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
