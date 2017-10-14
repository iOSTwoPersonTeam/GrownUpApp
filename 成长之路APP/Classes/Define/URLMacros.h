//
//  URLMacros.h
//  成长之路APP
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 hui. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h

/*
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */


#ifdef DEBUG

//#define                                                                                                                                                    REQUEST_URL      @"http://shandanapitest.51negoo.com/"      //测试接口地址
#define REQUEST_URL    @"http://tishengtestapi.51ts.cn/"      //测试接口地址
#define WebSchemeURL @"http://mtestshandan.51ts.cn/index.php?"  //WebViewController测试地址

#define                                                                                                                                                    NengGoREQUEST_URL          @"http://tishengtestapi.51ts.cn/"      //能go测试接口地址
#define                                                                                                                                                      NengGoNEWREQUEST_URL          @"http://apitest.51negoo.com/"      //能go新测试接口地址

#else

#define REQUEST_URL   @"http://chengjiaoapi.cnadtop.com/"      //正式接口地址
#define WebSchemeURL @"http://chengjiao.cnadtop.com/index.php?" //WebViewController正式地址

#define NengGoREQUEST_URL         @"http://trainddapi.51ts.cn/"      //能go正式接口地址
#define                                                                                                                                                      NengGoNEWREQUEST_URL          @"http://api.51negoo.com/"      //能go正式接口地址

#endif








#endif /* URLMacros_h */





