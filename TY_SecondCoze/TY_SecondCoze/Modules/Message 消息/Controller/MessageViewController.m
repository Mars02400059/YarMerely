//
//  MessageViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageUniparousTableViewCell.h"
#import "MessageChatViewController.h"

static NSString *const Cell = @"cell";

@interface MessageViewController ()
<
EMChatManagerDelegate,
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;

// 消息数组
@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation MessageViewController

// 通过获取DB中所有会话, 更新消息数组
- (void)tyq_messageArrayChange {
    // 获取消息数组
    [_messageArray removeAllObjects];
    
    /// 删除所有会话
//    [[EaseMob sharedInstance].chatManager removeAllConversationsWithDeleteMessages:YES append2Chat:YES];
    /*!
     @method
     @brief 获取当前登录用户的会话列表
     @param append2Chat  是否加到内存中。
     YES为加到内存中。加到内存中之后, 会有相应的回调被触发从而更新UI;
     NO为不加到内存中。如果不加到内存中, 则只会直接添加进DB, 不会有SDK的回调函数被触发从而去更新UI。
     @result 会话对象列表
     */
    
    NSArray *conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    [self.messageArray addObjectsFromArray:conversations];
    
    
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.messageArray = [NSMutableArray array];
    [self didUnreadMessagesCountChanged];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    [self addTableView];
    [self addNavigationBarView];
    self.navigationBarView.title = @"消息";
    
}

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 50) style:UITableViewStylePlain];
    _tableView.rowHeight = 85.f;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MessageUniparousTableViewCell class] forCellReuseIdentifier:Cell];
    [self.view addSubview:_tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageUniparousTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    EMConversation *conversation = _messageArray[indexPath.row];
    cell.conversation = conversation;
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    [bquery whereKey:@"accountnumber" equalTo:conversation.chatter];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            BmobObject *object = array[0];
            BmobFile *file = [object objectForKey:@"photoFile"];
            [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:file.url]];
            cell.titleLabel.text = [object objectForKey:@"nickname"];
        }
    }];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageChatViewController *chatVC = [[MessageChatViewController alloc] init];
    chatVC.hidesBottomBarWhenPushed = YES;
    EMConversation *conversation = _messageArray[indexPath.row];
    
    /*! chatter
     @property
     @brief 会话对方的用户名. 如果是群聊, 则是群组的id
     */
    chatVC.titleName = conversation.chatter;
    [self.navigationController pushViewController:chatVC animated:YES];
}


/*!
 @method
 @brief 未读消息数改变时的回调
 @discussion 当EMConversation对象的enableUnreadMessagesCountEvent为YES时,会触发此回调
 @result
 */
- (void)didUnreadMessagesCountChanged {
    
    [self tyq_messageArrayChange];
    // 通过未读消息数在tabBar上显示未读数
    
    NSUInteger unReadMessage = [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    if (unReadMessage) {
        
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd", unReadMessage];
    } else {
        self.navigationController.tabBarItem.badgeValue = nil;
        
    }
    
}


-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
