//
//  GroupViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupDetailsViewController.h"

@interface GroupViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSArray *groupArray;//群数组

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     显示的群的列表
     */
    
    EMError *error = nil;
    NSArray *publicGroupList = [[EaseMob sharedInstance].chatManager fetchMyGroupsListWithError:&error];
    if (!error) {
        
        self.groupArray = publicGroupList;
        NSLog(@" -- 获取09成功-- %lu",(unsigned long)publicGroupList.count);
        
    }


    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    
//注册tableview
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self addNavigationBarView];
  self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
//    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"加号"];//右按钮为添加人按钮
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --- 左按钮返回
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- tableview的datasouce.delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _groupArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    EMGroup *gro = _groupArray[indexPath.row];
    
    NSString *string = gro.groupSubject;
   
    cell.textLabel.text = string;
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GroupDetailsViewController *groupVC = [[GroupDetailsViewController alloc] init];
    EMGroup *gro = _groupArray[indexPath.row];
    groupVC.emgroup = gro;
    [self.navigationController pushViewController:groupVC animated:YES];
}


/*
#pragma mark --- . 添加人进群

-(void)tyq_navigationBarViewRightButtonAction{
        
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager addOccupants:@[@"8",@"6002"] toGroup:@"1478167384709" welcomeMessage:@"邀请信息" error:&error];
        if (!error) {
            
            NSLog(@"添加^^^^^^成功");
        }
}

*/
    





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
