//
//  MineInfoViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineInfoViewController.h"
#import "MineInfoTableViewCell.h"


static NSString *const Cell = @"cell";

@interface MineInfoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, strong) NSArray *infoArray;


@end

@implementation MineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableView];
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
}
- (NSArray *)infoArray {
    if (nil == _infoArray) {
        _infoArray = @[@"账号", @"昵称", @"简介"];
    }
    return _infoArray;
}
- (void)addTableView {
    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.infoArray.count * 50) style:UITableViewStylePlain];
    _infoTableView.dataSource = self;
    _infoTableView.delegate = self;
    [_infoTableView registerNib:[UINib nibWithNibName:@"MineInfoTableViewCell" bundle:nil] forCellReuseIdentifier:Cell];
    [self.view addSubview:_infoTableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    cell.titleLabel.text = self.infoArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
