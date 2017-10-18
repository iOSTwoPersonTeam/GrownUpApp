//
//  TDEaseChatManager.h
//  成长之路APP
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDEaseChatManager : NSObject<EMContactManagerDelegate>

/*
 * TDEaseChatmanager 单例
 */
+(id)shareManager;

/*
 * 配置环信数据
 */
-(void)setEaseChatBaseInformation;

/*
 * 环信进入后台
 */
- (void)easeClientDidEnterBackground:(UIApplication *)application;

/*
 *  环信将要从后台返回
 */
- (void)easeClientWillEnterForeground:(UIApplication *)application;

/*
 *  注册环信
 */
-(void)setRegisterEaseChatWithUsername:username password:password Succeed:(void(^)())succeess Error:(void(^)(EMError *aError))error;

/*
 *  环信登录
 */
-(void)setLogInEaseChatWithUsername:username password:password Succeed:(void(^)())succeess Error:(void(^)(EMError *aError))error;

/*
 *  退出环信
 */
-(void)setLogOutEaseChatWitLhSucceed:(void(^)())suceess failure:(void(^)(EMError *error))failure;

/*
 *  获取联系人列表
 */
-(NSArray *)getContactsFromServerAndSaveContactsList;

/*
 *  获取所有群组联系人列表
 */
-(NSArray *)getJoinGroupsContactList;

/*
 *  获取会话列表
 */
-(NSArray *)getConversationFromServerOrSaveConversationList;

/*
 *  申请添加好友
 */
-(void)applyAddContact:(NSString *)contactName message:(NSString *)message withSucceed:(void(^)())succeed Error:(void(^)(EMError *aError))error;

/*
 * 接受或者拒绝好友申请 isAccept 是Yes接受  No拒绝
 */
-(void)judgeAcceptInvitationStatus:(BOOL)isAccept forContact:(NSString *)contactName withSucceed:(void(^)())succeed Error:(void(^)(EMError *aError))error;





@end
