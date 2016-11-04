//
//  GroupMemberViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/4.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupMemberViewController.h"

@interface GroupMemberViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *occupantsListArray;
@end

@implementation GroupMemberViewController

- (void)viewDidAppear:(BOOL)animated {
    [[EaseMob sharedInstance].chatManager asyncFetchOccupantList:_emgroup.groupId completion:^(NSArray *occupantsList, EMError *error) {
        
        if (self.occupantsListArray) {
         
            [_occupantsListArray removeAllObjects];
            
        }
        
        [self.occupantsListArray addObjectsFromArray:occupantsList];
        [_myTableView reloadData];
        
        NSLog(@"*****%@",_occupantsListArray);
        
    } onQueue: nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.occupantsListArray = [NSMutableArray array];
    
    /*
     获取群成员
     */
    
    /*!
     @method
     @brief 同步方法，获取群组成员列表
     @param groupId    群组ID
     @param pError     错误信息
     @return  群组的成员列表（包含创建者）
     */
 //   - (NSArray *)fetchOccupantList:(NSString *)groupId error:(EMError **)pError;
    
    
    
    
    
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --- DataSource, Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _occupantsListArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = _occupantsListArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击方法");
}

-(void) tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}











@end
