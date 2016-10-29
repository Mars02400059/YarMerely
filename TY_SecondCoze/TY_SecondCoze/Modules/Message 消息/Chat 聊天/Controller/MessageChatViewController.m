//
//  MessageChatViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageChatViewController.h"
#import "StationView.h"
#import "MessageChatTableViewCell.h"
#import "MessageChatConversationModel.h"


// 操作台的高度
static CGFloat const stationViewHeight = 60.f;

static NSString *const Cell = @"cell";

@interface MessageChatViewController ()
<
EMChatManagerDelegate,
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource
>
// 消息tableView
@property (nonatomic, strong) UITableView *messageTableView;
// 控制台, (语音, 文字输入, 表情....)
@property (nonatomic, strong) StationView *stationView;
// 键盘的高度
@property (nonatomic, assign) CGFloat keyboardHeight;
// 存消息的数组
@property (nonatomic, strong) NSMutableArray *messageArray;


@end

@implementation MessageChatViewController

- (void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];

}

- (void)viewWillAppear:(BOOL)animated {
    [self didUnreadMessagesCountChanged];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 聊天管理器
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

#pragma mark -  发送一条文本消息
    
    /*!
     @method
     @brief 以字符串构造文本对象
     @discussion
     @param text 文本内容
     @result 文本对象
     */
    EMChatText *txtChat = [[EMChatText alloc] initWithText:@"要发送的消息"];
    /*!
     @method
     @brief 以文本对象创建文本消息体实例
     @discussion
     @param aChatText 文本对象
     @result 文本消息体
     */
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
    
    /*!
     @method
     @brief 创建消息实例（用于:创建一个新的消息）
     @discussion 消息实例会在发送过程中内部状态发生更改,比如deliveryState
     @param receiver 消息接收方
     @param bodies 消息体列表
     @result 消息实例
     */
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithReceiver:@"admin" bodies:@[body]];
    message.messageType = eMessageTypeChat;
    //message.messageType = eConversationTypeGroupChat;// 设置为群聊消息
    //message.messageType = eConversationTypeChatRoom;// 设置为聊天室消息
    
    message.deliveryState = eMessageDeliveryState_Delivered;
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
        //
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        //
        if (!error) {
            
            [self tyq_getconversation];
        }
    } onQueue:nil];
    
#pragma mark - 发送文本消息结束
    
    
    self.messageArray = [NSMutableArray array];
    
    [self addTableView];
    [self addstationView];
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
}



- (void)addTableView {

    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - stationViewHeight) style:UITableViewStylePlain];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    [_messageTableView registerClass:[MessageChatTableViewCell class] forCellReuseIdentifier:Cell];
    [self.view addSubview:_messageTableView];
}

- (void)addstationView {
    self.stationView = [[StationView alloc] initWithFrame:CGRectMake(0, self.view.height - stationViewHeight, self.view.width, stationViewHeight)];
    _stationView.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
    _stationView.layer.borderColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.000].CGColor;
    _stationView.layer.borderWidth = 1.f;
    [self.view addSubview:_stationView];
    
    
    // 键盘监听
    // 键盘将要出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tyq_KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    // 键盘将要消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tyq_KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tyq_HideKeyboard)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    [self.view addGestureRecognizer:gesture];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];

    cell.message = _messageArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
// 未读消息数改变的回调
- (void)didUnreadMessagesCountChanged {
    [self tyq_getconversation];
}


#pragma mark - 接受消息
#warning 不实时更新, 需要不停地更新
// 获取会话
- (void)tyq_getconversation {
    [_messageArray removeAllObjects];
    
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:_titleName conversationType:eConversationTypeChat];
    // 消息id加载消息
    NSArray *messageArray = [conversation loadNumbersOfMessages:100 withMessageId:nil];
    
    [_messageArray addObjectsFromArray:messageArray];
    [_messageTableView reloadData];

    
}

#pragma mark - 键盘相关
#warning 键盘将要出现或改变, 应该换成出现一个改变一个,
// 键盘将要出现
- (void)tyq_KeyboardWillShow:(NSNotification *)notification {


    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
    self.keyboardHeight = keyboardSize.height;
    
    _messageTableView.height -= _keyboardHeight;
    
    _stationView.y -= _keyboardHeight;
    
}
// 键盘将要消失
- (void)tyq_KeyboardWillHide:(NSNotification *)notification {

    _messageTableView.height += _keyboardHeight;
    
    _stationView.y += _keyboardHeight;
    
}
// 隐藏键盘
- (void)tyq_HideKeyboard {
    [_stationView.importTextField resignFirstResponder];
}

- (void)tyq_navigationBarViewLeftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}
//开始编辑：
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

//点击return按钮所做的动作：
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
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
