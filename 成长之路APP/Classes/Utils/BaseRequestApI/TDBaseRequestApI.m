
//
//  TDBaseRequestApI.m
//  成长之路APP
//
//  Created by mac on 2017/7/31.
//  Copyright © 2017年 hui. All rights reserved.
//
/*
 使用注意
 1.AFHTTPRequestOperationManager 在AFN 3.0后废弃,开始使用AFHTTPSessionManager
 2.AFN发送的所有请求都是异步,不会阻塞主线程
 3.默认情况下是JSON解析
 4.block代码块内容是在get和post请求完成之后才执行
 5.block默认在主线程执行，如果希望修改代码块在子线程执行如下修改 manager.completionQueue = dispatch_get_global_queue;
 */


#import "TDBaseRequestApI.h"

//请求超时
#define TIMEOUT 15
//安全证书Key
#define APPKEY [NSString stringWithFormat:@"%@",@"peixunduoduo"]
//安全证书秘钥
#define APPSECRET [NSString stringWithFormat:@"%@",@"7f777ad461270e150f6754d6b3de45c4"]


@implementation FormData



@end


@interface TDBaseRequestApI ()
{
    NSURLSessionDownloadTask *_downloadTask; //下载任务
}


@end

@implementation TDBaseRequestApI

static TDBaseRequestApI *_manager =nil;

#pragma mark -------创建单例
/*
 *  创建请求管理者  TDBaseRequestApI单利形式
 */
+(TDBaseRequestApI *)shareManager
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
 * 初始化内存管理
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


#pragma mark -----创建请求管理者AFHTTPSessionManager
-(AFHTTPSessionManager *)sessionManager
{
    //创建请求管理者
    AFHTTPSessionManager *sessionManager =[AFHTTPSessionManager manager];
    //block 线程修改
    sessionManager.completionQueue =dispatch_get_global_queue(0, 0);
    //能够识别的数据类型
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求主体
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    sessionManager.requestSerializer.timeoutInterval = TIMEOUT;

    
    return sessionManager;
    
}


#pragma mark --字典中需要传递的参数(进行了MD5加密以及常规配置)
-(NSMutableDictionary *)appWithDicRequestSecurity
{
    NSDate *datenow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter stringFromDate:datenow];
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];// 时间转时间戳的方法
    //MD5加密标签
    NSString* sign = [[NSString stringWithFormat:@"%@%@",timestamp,APPSECRET] getMd5];
    //字典
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:timestamp forKey:@"time"];
    [parameters setObject:APPSECRET forKey:@"appserect"];
    [parameters setObject:APPKEY forKey:@"appkey"];
    [parameters setObject:sign forKey:@"sign"];
    
    return parameters;
}


#pragma mark --block 请求数据
/*
 * GET请求:block
 */
-(void)GETDataWithURL:(NSString *)url parameters:(id)parameters succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure
{
   //创建请求管理者
    AFHTTPSessionManager *manager =[self sessionManager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject ==nil) {
            
            return;
        }
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
             succeed(responseObject);
        });
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            failure(error);
        });
    }];

}


/*
 * POST请求 block
 */
-(void)POSTDataWithURL:(NSString *)url parameters:(id)parameters succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure
{
   //创建请求管理者
    AFHTTPSessionManager *manager =[self sessionManager];
    //请求主体
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (responseObject ==nil) {
                return;
            }
            succeed(responseObject);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            failure(error);
        });
    }];

}





#pragma mark ---上传文件
/**
 *  POST 上传文件    附带 NSURLSessionDataTask 回调  多文件上传和单文件上传区别在于文件名称
 *
 *  @param url    链接
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
               failure:(void (^)(NSError *error))failure

{
    // 获得网络管理者
    AFHTTPSessionManager *manager =[self sessionManager];
    
    // 实例化请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /*
          Data: 要上传的[二进制数据]
          name: 服务器参数的名称
          fileName: 要保存在服务器上的[文件名]
          mingType: 上传文件的[mimeType]
         */
        for (FormData *data in formDataArray) {
            
            if (data.data) {
                
                [formData appendPartWithFileData:data.data name:data.name fileName:data.filename mimeType:data.mimeType];
                
            }else{
                
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:data.filePath] name:data.name fileName:data.filename mimeType:data.mimeType error:nil];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        //
        // 给Progress添加监听 KVO
        //注意 要用GCD主线程调用UI
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
             progress(uploadProgress.fractionCompleted);
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            succeed(responseObject);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            failure(error);
        });
    }];

}





#pragma mark ---下载文件
/**
 *  POST 上传文件    附带 NSURLSessionDataTask 回调  多文件上传和单文件上传区别在于文件名称
 *
 *  @param url        链接
 *  @param progress   进度
 *  @param succeed    成功回调
 *  @param failure    失败回调
 */
-(void)DownloadWithURL:(NSString *)url progress:(void (^)(float))progress success:(void (^)(id))succeed failure:(void (^)(NSError *))failure
{
    
    // 获得网络管理者
    AFHTTPSessionManager *manager =[self sessionManager];

    // 实例化请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 开始下载(异步)
   _downloadTask =[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 打印下下载进度
        //        NSLog(@"进度:%lf  完成进度：%lld  总进度：%lld",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount,downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            progress(downloadProgress.fractionCompleted);
        });
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        // 设置文件的保存地址
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //文件下载并保存成功后的回调
            if (error) {
                
                failure(error);
            }
            else{
                
                succeed(filePath.path);
            }
        });
        
    }];
    
    //开始启动任务
    [_downloadTask resume];
    
}


/**
 *  暂停操作  断点续传
 */
- (void)taskPause
{
    [_downloadTask suspend];

}


/**
 *  继续操作  断点续传
 */
- (void)taskResume
{
    [_downloadTask resume];

}


/**
 *  取消操作
 */
- (void)taskCancel
{

    [_downloadTask cancel];

}



#pragma mark ----网络状况监测
-(void)netWorkStateChange
{
    //将window显示在最前面
    UIWindow *window =[[UIApplication sharedApplication].delegate window];
    
    //1.获得一个网络状态监听管理者
    AFNetworkReachabilityManager *netWorkmanager = [AFNetworkReachabilityManager sharedManager];
    
    //2.监听状态的改变(当网络状态改变的时候就会调用该block)
    [netWorkmanager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
        AFNetworkReachabilityStatusUnknown       = -1,  未知
        AFNetworkReachabilityStatusNotReachable  = 0,   没有网络
        AFNetworkReachabilityStatusReachableViaWWAN = 1,    3G|4G
        AFNetworkReachabilityStatusReachableViaWiFi = 2,   WIFI
        */
        
    // 使用MBProgressHUD三方库创建弹框，给出相应的提示
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
        
    switch (status) { case AFNetworkReachabilityStatusReachableViaWiFi:
            NSLog(@"wifi---无线网络");
            // 弹框提示的内容
            hud.labelText = @"WiFi在线";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN: NSLog(@"3G|4G --手机流量");
            hud.labelText = @"2G/3G/4G";
            break;
        case AFNetworkReachabilityStatusNotReachable: NSLog(@"没有网络");
            hud.labelText = @"世界上最遥远的距离就是没网";
            break;
        case AFNetworkReachabilityStatusUnknown:
            NSLog(@"未知");
            break;
            
        default:
        break;
            
      }
       
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 显示时间2s
            sleep(2);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 让弹框消失
                [MBProgressHUD hideHUDForView:window animated:YES];
            });
        });
        
    }];
    
    //3.手动开启 开始监听
    [netWorkmanager startMonitoring];


}





@end





