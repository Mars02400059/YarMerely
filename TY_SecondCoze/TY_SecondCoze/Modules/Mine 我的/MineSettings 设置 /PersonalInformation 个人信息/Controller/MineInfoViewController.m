//
//  MineInfoViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineInfoViewController.h"
#import "MineInfoTableViewCell.h"
#import "MinePersonInfoModel.h"
#import "RevampPersonInfoViewController.h"

static NSString *const Cell = @"cell";

@interface MineInfoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) MinePersonInfoModel *personInfoModel;

@end

@implementation MineInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    // BMOB模糊查询
    // 按用户环信账号查询BMOB数据
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    // 添加playerName不是小明的约束条件
    [bquery whereKey:@"accountnumber" equalTo: [[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        BmobObject *object = array[0];
        self.personInfoModel = [[MinePersonInfoModel alloc] init];
        _personInfoModel.accountnumber = [object objectForKey:@"accountnumber"];
        _personInfoModel.nickname = [object objectForKey:@"nickname"];
        _personInfoModel.sex = [object objectForKey:@"sex"];
        _personInfoModel.age = [object objectForKey:@"age"];
        _personInfoModel.autograph = [object objectForKey:@"autograph"];
        [_infoTableView reloadData];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableView];
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"修改"];
    
}
- (NSArray *)infoArray {
    if (nil == _infoArray) {
        _infoArray = @[@"账号:", @"昵称:", @"性别:", @"年龄:", @"签名:"];
    }
    return _infoArray;
}
- (void)addTableView {
    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.infoArray.count * 60 + 30) style:UITableViewStylePlain];
    _infoTableView.dataSource = self;
    _infoTableView.delegate = self;
    _infoTableView.scrollEnabled = NO;
    [_infoTableView registerNib:[UINib nibWithNibName:@"MineInfoTableViewCell" bundle:nil] forCellReuseIdentifier:Cell];
    [self.view addSubview:_infoTableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.infoArray.count - 1) {
        return 90.f;
    }
    return 60.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    cell.titleLabel.text = self.infoArray[indexPath.row];
    //    MinePersonInfoModel *personInfoModel = self.personInfoArray[0];
    
    if (![_personInfoModel.age isEqualToString:@""]) {
        if (indexPath.row == 0) {
            cell.infoLabel.text = _personInfoModel.accountnumber;
            
        } else if (indexPath.row == 1) {
            cell.infoLabel.text = _personInfoModel.nickname;
            
        } else if (indexPath.row == 2) {
            cell.infoLabel.text = _personInfoModel.sex;
            
        } else if (indexPath.row == 3) {
            cell.infoLabel.text = _personInfoModel.age;
            
        } else if (indexPath.row == 4) {
            cell.infoLabel.text = _personInfoModel.autograph;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tyq_navigationBarViewLeftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tyq_navigationBarViewRightButtonAction {
    RevampPersonInfoViewController *personInfoVC = [[RevampPersonInfoViewController alloc] init];
    personInfoVC.personModel = _personInfoModel;
    [self.navigationController pushViewController:personInfoVC animated:YES];
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
