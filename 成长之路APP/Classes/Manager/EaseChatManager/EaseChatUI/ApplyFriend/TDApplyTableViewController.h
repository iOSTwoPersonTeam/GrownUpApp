//
//  TDApplyTableViewController.h
//  成长之路APP
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ApplyStyleFriend            = 0,
    ApplyStyleGroupInvitation,
    ApplyStyleJoinGroup,
}ApplyStyle;

@interface TDApplyTableViewController : UITableViewController
{
    NSMutableArray *_dataSource;
}

@property (strong, nonatomic, readonly) NSMutableArray *dataSource;

+ (instancetype)shareController;

- (void)addNewApply:(NSDictionary *)dictionary;

- (void)removeApply:(NSString *)aTarget;

- (void)loadDataSourceFromLocalDB;

- (void)clear;

@end
