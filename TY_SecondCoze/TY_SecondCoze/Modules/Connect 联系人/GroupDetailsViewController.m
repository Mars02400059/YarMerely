//
//  GroupDetailsViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/2.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import <EMGroup.h>
#import <EMChatManagerGroupDelegate.h>
@interface GroupDetailsViewController ()
<
EMChatManagerDelegate,
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) UITableView *myTableview;
@end

@implementation GroupDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     获取群详情,就是获取群成员
     */
//    NSLog(@"888%@",_emgroup.groupId);
    
    self.myTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _myTableview.dataSource = self;
    _myTableview.delegate = self;
    [self.view addSubview:_myTableview];
   
    [_myTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    
    [self addNavigationBarView];
     self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    
    // Do any additional setup after loading the view.
}
//左按钮
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- tableVIew dataSouce,delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
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
