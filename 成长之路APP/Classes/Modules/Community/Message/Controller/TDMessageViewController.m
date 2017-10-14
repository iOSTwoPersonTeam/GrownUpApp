//
//  TDMessageViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDMessageViewController.h"

@interface TDMessageViewController ()

@end

@implementation TDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    环信ID:@"8001"
//    聊天类型:EMConversationTypeChat
//        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:testAccount conversationType:EMConversationTypeChat];
//        [self.navigationController pushViewController:chatController animated:YES];
    
    //单聊
        TDEaseChatViewController *chatController = [[TDEaseChatViewController alloc] initWithConversationChatter:[TDUserInfo getUser].USERNAME conversationType:EMConversationTypeChat];
        [self.navigationController pushViewController:chatController animated:YES];
    
//    //群聊
//    TDEaseChatViewController *chatController = [[TDEaseChatViewController alloc] initWithConversationChatter:teatGroupId conversationType:EMConversationTypeGroupChat];
//    [self.navigationController pushViewController:chatController animated:YES];
}




@end
