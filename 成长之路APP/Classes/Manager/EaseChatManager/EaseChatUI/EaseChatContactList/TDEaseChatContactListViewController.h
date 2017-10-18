//
//  TDEaseChatContactListViewController.h
//  成长之路APP
//
//  Created by mac on 2017/10/14.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <EaseUI/EaseUI.h>

@interface TDEaseChatContactListViewController : EaseUsersListViewController

//好友请求变化时，更新好友请求未处理的个数
- (void)reloadApplyView;

//群组变化时，更新群组页面
- (void)reloadGroupView;

//好友个数变化时，重新获取数据
- (void)reloadDataSource;

//添加好友的操作被触发
- (void)addFriendAction;

@end
