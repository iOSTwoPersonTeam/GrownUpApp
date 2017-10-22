//
//  TDEaseChatConfig.h
//  成长之路APP
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#ifndef TDEaseChatConfig_h
#define TDEaseChatConfig_h

#import "TDEaseChatManager.h"
#import "TDEaseChatViewController.h"
#import "TDEaseConversationListViewController.h"
#import "TDEaseChatContactListViewController.h"

//#define TDEaseChatAppKey     @"tidoo#ts"   //环信注册的AppKey
//自己注册的
#define TDEaseChatAppKey     @"chengdenghui#trainmore"   //环信注册的AppKey
//#define TDEaseChatAppKey     @"easemob-demo#chatdemoui"   //环信注册的AppKey  账号12512860269  密码:123456 可以直播

#if DEBUG
#define TDEaseChatApnsCertName  @"tidoo"   //apnsCertName:推送证书名 测试
#else
#define TDEaseChatApnsCertName  @"tidoo_des"   //apnsCertName:推送证书名 正式
#endif

//测试账号和密码
#define testAccount    @"test_f6dba05d53df7d9944ac69bf10c2bb21"
#define textPassword   @"test_64de8bff6e0b27235b68ad1fc791efe8"
#define testRoomId     @"test_12f56318827defa69f787618b0900861"
#define teatGroupId    @"201915763777339820"




#endif /* TDEaseChatConfig_h */
