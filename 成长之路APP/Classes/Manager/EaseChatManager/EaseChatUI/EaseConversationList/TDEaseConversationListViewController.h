//
//  TDEaseConversationListViewController.h
//  成长之路APP
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <EaseUI/EaseUI.h>

@interface TDEaseConversationListViewController : EaseConversationListViewController

@property (strong, nonatomic) NSMutableArray *conversationsArray;

- (void)refresh;
- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;


@end
