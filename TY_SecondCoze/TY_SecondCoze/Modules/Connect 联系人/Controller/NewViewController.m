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

@interface NewViewController ()<UITableViewDelegate,UITableViewDataSource>




@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) TYQLabel *label;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    
    
    self.navigationItem.title = @"新朋友";
    
#pragma mark --- 创建tableview
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    

    
     [self addNavigationBarView];
     self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];

    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    self.label = [[TYQLabel alloc] initWithFrame:CGRectMake(10, 30, WIDTH / 3 * 2, cell.frame.size.height)];
    _label.backgroundColor = [UIColor greenColor];
    [cell.contentView addSubview:_label];
    InfoModel *infoModel = _infoArray[indexPath.row];
    _label.text = infoModel.username;
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
