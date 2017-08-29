//
//  TDUserInfo.h
//  成长之路APP
//
//  Created by mac on 2017/8/14.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDUserModel : NSObject

@property (nonatomic, strong) NSString *UCODE; //用户ucode
@property (nonatomic, strong) NSString *USERNAME; //用户名
@property (nonatomic, strong) NSString *MOBILE; //手机号
@property (nonatomic, strong) NSString *PASSWORD; //密码
@property (nonatomic, strong) NSString *USERTYPE; //用户类型 0普通用户 1个人商家 2企业商家
@property (nonatomic, strong) NSString *STATUS; //用户状态0 、禁用 1、启用
@property (nonatomic, strong) NSString *FROMAPP; //0 H5 1 android 2 ios
@property (nonatomic, strong) NSString *SEX; //性别(1:男;2:女)
@property (nonatomic, strong) NSString *ICON; //头像(没有上传头像给默认头像)
@property (nonatomic, strong) NSString *SICON; //压缩头像
@property (nonatomic, strong) NSString *NICKNAME; //用户昵称
@property (nonatomic, strong) NSString *LOGINFROM; //第三方登录来自于(1qq，2新浪微搏，3腾讯微搏,4微信网页授权 5微信登陆 )多个以逗号隔开
@property (nonatomic, strong) NSString *CATEGORYPCODE; //服务分类一级编号
@property (nonatomic, strong) NSString *CATEGORYCCODE; //服务分类二级编号
@property (nonatomic, strong) NSString *CATEGORYSCODE; //服务分类三级编号
@property (nonatomic, strong) NSString *USERKEY; //第三方登录的唯一key值(多个以逗号隔开)
@property (nonatomic, strong) NSString *QQ; //QQ
@property (nonatomic, strong) NSString *WX; //微信号
@property (nonatomic, strong) NSString *XL; //新浪微博号
@property (nonatomic, strong) NSString *BINDING_MOBILE; //绑定手机号
@property (nonatomic, strong) NSString *REGIP; //注册ip
@property (nonatomic, strong) NSString *CREATETIME; //注册时间
@property (nonatomic, strong) NSString *UPDATETIME; //修改时间
@property (nonatomic, strong) NSString *ID; //用户id

@property (nonatomic, strong) NSString *merchantid; //商家id
@property (nonatomic, strong) NSString *shop_id; //商家店铺id
@property (nonatomic, strong) NSString *AUDIT; //1未审核 2审核通过 3审核未通过
@property (nonatomic, strong) NSString *AUDITORID; //审核者id
@property (nonatomic, strong) NSString *AUDITREASON; //审核原因
@property (nonatomic, strong) NSString *BUSINES; //1个人商家入驻 2企业商家入驻
@property (nonatomic, strong) NSString *CARDCODE; //身份证号
@property (nonatomic, strong) NSString *COMPADDRESS; //公司地址
@property (nonatomic, strong) NSString *COMPNAME; //公司名称
@property (nonatomic, strong) NSString *LCARDICON; //身份证反面照片
@property (nonatomic, strong) NSString *LICENCESCODE; //企业营业执照号
@property (nonatomic, strong) NSString *LICENCESICON; //企业营业执照
@property (nonatomic, strong) NSString *NAME; //真实姓名
@property (nonatomic, strong) NSString *RCARDICON; //身份证正面照片
@property (nonatomic, strong) NSString *TYPE; //1媒体商家 2非媒体商家
@property (nonatomic, strong) NSString *USERID; //用户id

@end


@interface TDUserInfo : NSObject

+ (BOOL)saveUserInfo:(NSDictionary *)userInfo;

+ (TDUserModel *)getUser;

+ (BOOL)removeUserInfo;

@end
