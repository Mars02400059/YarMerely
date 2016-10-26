//
//  MineSettingViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/26.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineSettingViewController.h"
#import "MineSpaceTableViewCell.h"
#import "MineGrayBackTableViewCell.h"
#import "MineImageTableViewCell.h"


static NSString *const spaceCell = @"spaceCell";
static NSString *const backCell = @"backCell";
static NSString *const imageCell = @"imageCell";



@interface MineSettingViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableViewArray;


@end

@implementation MineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.000];
    [self addTableView];
    
    [self addNavigationBarView];
    self.navigationBarView.backColor.alpha = 1.f;
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
}

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 50 * 4 + 10) style:UITableViewStylePlain];
    _tableView.scrollEnabled = NO;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineSpaceTableViewCell" bundle:nil] forCellReuseIdentifier:spaceCell];
    [_tableView registerNib:[UINib nibWithNibName:@"MineGrayBackTableViewCell" bundle:nil] forCellReuseIdentifier:backCell];
    [_tableView registerNib:[UINib nibWithNibName:@"MineImageTableViewCell" bundle:nil] forCellReuseIdentifier:imageCell];
    
    
    [self.view addSubview:_tableView];

}
- (NSArray *)tableViewArray {
    if (nil == _tableViewArray) {
        _tableViewArray = @[@"修改密码", @"夜间模式", @"关于我们", @"", @"退出登录"];
    }
    return _tableViewArray;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.tableViewArray.count - 2) {
        return 10.f;
    }
    return 50.f;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < self.tableViewArray.count - 2) {
        MineImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell];
        cell.title = self.tableViewArray[indexPath.row];
        return cell;
        
    } else if (indexPath.row == self.tableViewArray.count - 1) {
        MineSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:spaceCell];
        cell.title = self.tableViewArray[indexPath.row];
        return cell;
    } else {
        MineGrayBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:backCell];
        return cell;
    }

}

- (void)tyq_navigationBarViewLeftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
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
