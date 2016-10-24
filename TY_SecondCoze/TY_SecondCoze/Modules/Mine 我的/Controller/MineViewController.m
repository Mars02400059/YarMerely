//
//  MineViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineViewController.h"

static NSString *const cellIdetifeir = @"cell";

@interface MineViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
/// 头视图背景图片
@property (nonatomic, strong) TYQImageView *headImageView;
/// 头视图背景图片宽度
@property (nonatomic, assign) CGFloat headImageViewWidth;
/// 头视图背景图片高度
@property (nonatomic, assign) CGFloat headImageViewHeight;



@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    

    [self addSubsView];
    [self addNavigationBarView];
    self.navigationBarView.alpha = 0.f;
    self.navigationBarView.rightButtonBackImage = [UIImage imageNamed:@"设置"];
}

- (void)addSubsView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdetifeir];
    [self.view addSubview:_tableView];
    
    self.headImageView = [[TYQImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    _headImageView.backgroundColor = [UIColor redColor];
    _headImageView.frame = CGRectMake(0, 0, WIDTH, WIDTH * 0.75);
    _tableView.tableHeaderView = _headImageView;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifeir];
    
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
