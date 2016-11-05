//
//  MineInfoViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineInfoViewController.h"
#import "MineInfoTableViewCell.h"
#import "RecomposePersonInfoViewController.h"

static NSString *const Cell = @"cell";

@interface MineInfoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) BmobObject *object;

@end

@implementation MineInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    // 添加playerName不是小明的约束条件
    [bquery whereKey:@"accountnumber" equalTo: [[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            self.object = array[0];
            [_infoTableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableView];
    [self addNavigationBarView];
    self.navigationBarView.title = @"个人信息";
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"编辑"];
}
- (NSArray *)infoArray {
    if (nil == _infoArray) {
        _infoArray = @[@"账号:", @"昵称:", @"性别:", @"年龄:", @"签名:"];
    }
    return _infoArray;
}
- (void)addTableView {
    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.infoArray.count * 50 + 50) style:UITableViewStylePlain];
    _infoTableView.scrollEnabled = NO;
    _infoTableView.dataSource = self;
    _infoTableView.delegate = self;
    [_infoTableView registerNib:[UINib nibWithNibName:@"MineInfoTableViewCell" bundle:nil] forCellReuseIdentifier:Cell];
    [self.view addSubview:_infoTableView];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.infoArray.count - 1) {
        return 100.f;
    }
    return 50.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    cell.titleLabel.text = self.infoArray[indexPath.row];
    if (![[_object objectForKey:@"nickname"] isEqual:@""]) {
        if (0 == indexPath.row) {
            cell.infoLabel.text = [_object objectForKey:@"accountnumber"];
        } else if (1 == indexPath.row) {
            cell.infoLabel.text = [_object objectForKey:@"nickname"];
        } else if (2 == indexPath.row) {
            cell.infoLabel.text = [_object objectForKey:@"age"];
        } else if (3 == indexPath.row) {
            cell.infoLabel.text = [_object objectForKey:@"sex"];
        } else if (4 == indexPath.row) {
            cell.infoLabel.text = [_object objectForKey:@"autograph"];
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
    [self presentViewController:[[RecomposePersonInfoViewController alloc] init] animated:YES completion:nil];
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
