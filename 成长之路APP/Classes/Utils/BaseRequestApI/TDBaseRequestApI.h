//
//  TDBaseRequestApI.h
//  成长之路APP
//
//  Created by mac on 2017/7/31.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用来封装文件数据的模型
 */
@interface FormData : NSObject

// 注意：        filePath 跟 data 选一个就好了 根据需要选择, 两个都有值会默认选择上传 data 的数据, filePath数据则不上传
// filePath:    通过文件路径上传文件
// data:        通过二进制数据上传文件

/**
 *  文件名路径
 */
@property (nonatomic, copy) NSString *filePath;

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end



@interface TDBaseRequestApI : NSObject

/*
 *  TDBaseRequesteAPI 单利
 */
+(TDBaseRequestApI *)shareManager;


#pragma mark ---NSDictionary 传递的字典参数
-(NSMutableDictionary *)appWithDicRequestSecurity;

#pragma mark --block的形式传值
/*
 * get请求
 */
-(void)GETDataWithURL:(NSString *)url parameters:(id)parameters succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;
/*
 * post请求
 */
-(void)POSTDataWithURL:(NSString *)url parameters:(id)parameters succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;


#pragma mark --上传文件
/**
 *  POST 上传文件    附带 NSURLSessionDataTask 回调  多文件上传和单文件上传区别在于文件名称
 *
 *  @param url        链接
 *  @param params 参数
 *  @param formDataArray 通过 FormData 模型 创建上传文件模型 以数组参数传入 单个文件:[formData] 多个文件:[formData1,formData2,....]
 *  FormData的 data属性 数据的NSdata类型 name为文件名称 filename文件名带后缀
 *  mimeType 格式类型
 *  @param progress   进度
 *  @param succeed    成功回调
 *  @param failure    失败回调
 */
- (void)UploadWithURL:(NSString *)url
                 params:(NSDictionary *)params
                 formDataArray:(NSArray *)formDataArray
                 progress:(void (^)(float progress))progress
                 success:(void (^)(id responseObject))succeed
                 failure:(void (^)(NSError *error))failure;




#pragma mark --下载文件
/**
 *  POST 上传文件    附带 NSURLSessionDataTask 回调  多文件上传和单文件上传区别在于文件名称
 *
 *  @param url        链接
 *  @param progress   进度
 *  @param succeed    成功回调
 *  @param failure    失败回调
 */
- (void)DownloadWithURL:(NSString *)url
                progress:(void (^)(float progress))progress
                success:(void (^)(id responseObject))succeed
                failure:(void (^)(NSError *error))failure;

/**
 *  暂停操作  断点续传
 */
- (void)taskPause;
/**
 *  继续操作  断点续传
 */
- (void)taskResume;
/**
 *  取消操作
 */
- (void)taskCancel;

/*
 *  网络状况监测
 */
-(void)netWorkStateChange;



@end





