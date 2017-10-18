//
//  TDEaseChatManager.m
//  成长之路APP
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDEaseChatManager.h"

@interface TDEaseChatManager ()

@end

static  TDEaseChatManager *_manager =nil;

@implementation TDEaseChatManager

#pragma mark ---创建单例
/*
 *  创建请求管理者 单例形式
 */
+(id)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager ==nil) {
            _manager =[[self alloc] init];
        }
    });
    return _manager;
}

/*
 初始化内存管理
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager ==nil) {
            _manager =[super allocWithZone:zone];
        }
    });
    return _manager;
}


#pragma mark ---配置环信基本信息
-(void)setEaseChatBaseInformation
{
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:TDEaseChatAppKey];
//    options.apnsCertName = TDEaseChatApnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];

    //注册一个监听对象到监听列表中
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}

#pragma mark ---环信进入后台
- (void)easeClientDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

#pragma mark ---环信将要从后台返回
- (void)easeClientWillEnterForeground:(UIApplication *)application
{
   [[EMClient sharedClient] applicationWillEnterForeground:application];
}

#pragma mark ---注册环信基本信息
-(void)setRegisterEaseChatWithUsername:username password:password Succeed:(void(^)())succeess Error:(void(^)(EMError *aError))error
{
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     
        [[EMClient sharedClient] registerWithUsername:username password:password completion:^(NSString *aUsername, EMError *aError) {
     
                 dispatch_async(dispatch_get_main_queue(), ^{
         
                     if (!aError) {
                         NSLog(@"注册成功");
                         if (succeess) {
                             succeess();
                         }
                         
                     }else{
                         NSLog(@"注册失败");
                         if (error) {
                             error(aError);
                         }
                     }
                 });
         
         
         }];
     
    });
}

#pragma mark ---环信登录
-(void)setLogInEaseChatWithUsername:username password:password Succeed:(void(^)())succeess Error:(void(^)(EMError *aError))error
{
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     //设置是否自动登录
     [[EMClient sharedClient].options setIsAutoLogin:YES];
     
     [[EMClient sharedClient] loginWithUsername:username ? username : testAccount
                                       password:password ? password :textPassword
                                     completion:^(NSString *aUsername, EMError *aError) {
                                         
                     dispatch_async(dispatch_get_main_queue(), ^{
                                             
                                 if (!aError) {
                                     NSLog(@"登录成功");
                                     
                                     if (succeess) {
                                         succeess();
                                     }
                                     
                                 } else {
                                     NSLog(@"登录失败");
                                     if (error) {
                                         error(aError);
                                     }
                                 }
                     });

             }];
    
    });
    
}

#pragma mark --环信退出
-(void)setLogOutEaseChatWitLhSucceed:(void(^)())suceess failure:(void(^)(EMError *error))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                DLog(@"退出登录失败%@,%u",error.errorDescription,error.code);
                if (failure) {
                    failure(error);
                }
            }
            else{
                DLog(@"环信退出成功");
                if (suceess) {
                    suceess();
                }
            }
        });
    });
    
}

/*
 *  联系人列表
 */
-(NSArray *)getContactsFromServerAndSaveContactsList
{
    //从服务器获取联系人列表
    [[EMClient sharedClient].contactManager getContactsFromServerWithError:nil];
   //从本地获取联系人列表
   NSArray *contactArray = [[EMClient sharedClient].contactManager getContacts];
    
    return contactArray;
}

/*
 *  获取所有群组联系人列表
 */
-(NSArray *)getJoinGroupsContactList
{
    //获取加入团列表
    NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
    
    return groupArray;
}

/*
 *  获取会话列表
 */
-(NSArray *)getConversationFromServerOrSaveConversationList
{
    //获取会话列表
    NSArray *conversationsArray = [[EMClient sharedClient].chatManager getAllConversations];
    
    return conversationsArray;
}

/*
 *  申请添加好友
 */
-(void)applyAddContact:(NSString *)contactName message:(NSString *)message withSucceed:(void(^)())succeed Error:(void(^)(EMError *aError))error
{
    //先判断是否已经是好友
    NSArray *userlist = [[EMClient sharedClient].contactManager getContacts];
    for (NSString *username in userlist) {
        if ([username isEqualToString:contactName]) {
            NSLog(@"已经是好友-------");
            return;
        }
    }
    
    EMError *emError = [[EMClient sharedClient].contactManager addContact:contactName message:message];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!emError) {
            if (succeed) {
                succeed();
            }
        }
        else{
            if (error) {
                error(emError);
            }
        }
    });
}

/*
 * 接受或者拒绝好友申请 isAccept 是Yes接受  No拒绝
 */
-(void)judgeAcceptInvitationStatus:(BOOL)isAccept forContact:(NSString *)contactName withSucceed:(void(^)())succeed Error:(void(^)(EMError *aError))error
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        EMError *emError =isAccept ?[[EMClient sharedClient].contactManager acceptInvitationForUsername:contactName] :[[EMClient sharedClient].contactManager declineInvitationForUsername:contactName];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!emError) {
                if (succeed) {
                    succeed();
                }
            }
            else{
                if (error) {
                    error(emError);
                }
            }
        });
    });
}

#pragma mark ---delegate--
#pragma mark ---环信delegate
//监听好友申请消息
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:aUsername,@"username",aMessage,@"message", nil];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dic forKey:@"dic"];
    [userDefaults synchronize];
    NSLog(@"来自%@的好友申请",aUsername);
}









@end
