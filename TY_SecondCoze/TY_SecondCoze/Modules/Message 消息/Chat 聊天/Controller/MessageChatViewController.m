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


// 操作台的高度
static CGFloat const stationViewHeight = 60.f;

static NSString *const Cell = @"cell";

@interface MessageChatViewController ()
<
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
@property (nonatomic, strong) NSArray *messageArray;


@end

@implementation MessageChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addTableView];
    [self addstationView];
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
}

- (NSArray *)messageArray {
    if (nil == _messageArray) {
        
        /*!
         @method
         @brief 根据消息id加载它之前的指定条数消息
         @param aCount 要加载的消息条数
         @param messageId 消息id，如果传nil就是取最后一条消息
         @discussion
         加载后的消息按照升序排列（不包含传入的messageId对应的消息）;
         @result 加载的消息列表
         */
        _messageArray = [_conversation loadNumbersOfMessages:30 withMessageId:_conversation.latestMessage.messageId];

    }
    return _messageArray;
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

    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];

    cell.message = _messageArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

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
