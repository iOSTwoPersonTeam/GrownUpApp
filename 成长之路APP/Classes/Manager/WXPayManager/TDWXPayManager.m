//
//  TDWXPayManager.m
//  成长之路APP
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDWXPayManager.h"
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>

@implementation DWWXPaySuccessModels

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)wxPaySuccessWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    //防止程序case
}

@end



@interface TDWXPayManager ()

@end

static TDWXPayManager *_manager =nil;

@implementation TDWXPayManager
/*
 创建请求管理者 单例形式
 */
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
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


#pragma mark ---检测是否安装微信
+ (BOOL)get_isWXAppInstalled {
    return [WXApi isWXAppInstalled];
}

#pragma mark ---判断当前微信的版本是否支持OpenApi
+ (BOOL)get_isWXAppSupportApi {
    return [WXApi isWXAppSupportApi];
}

#pragma mark ---获取微信的itunes安装地址
+ (NSString *)getWXAppInstallUrl {
    return [WXApi getWXAppInstallUrl];
}

#pragma mark ---获取当前微信SDK的版本号
+ (NSString *)getApiVersion {
    return [WXApi getApiVersion];
}

#pragma mark ---向微信终端程序注册第三方应用
- (BOOL)get_RegisterApp:(NSString *)appid enableMTA:(BOOL)isEnableMTA {
    
    BOOL isbool = [WXApi registerApp:appid enableMTA:isEnableMTA];
    
    return isbool;
}


#pragma mark ---首次签名并转化付款的XML格式--
- (NSString *)get_payParametersSetTradeTitle:(NSString *)tradeTitle total_fee:(NSString *)total_fee
{
    //============================================================
    // 支付流程实现
    // 客户端操作     (实际操作应由服务端操作)
    //============================================================
    NSString *totalFee  =[NSString stringWithFormat:@"%.0f",[total_fee floatValue] *100];                                         //交易价格1表示0.01元，10表示0.1元
    NSString *tradeNO   =[self dw_getNonce_str];                       //随机字符串变量 这里最好使用和安卓端一致的生成逻辑
    NSString *addressIP = [NSString dw_getIPAddress];                        //设备IP地址,请再wifi环境下测试,否则获取的ip地址为error,正确格式应该是8.8.8.8
    NSString *orderNo   = [NSString stringWithFormat:@"%ld",time(0)];   //随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
    NSString *notifyUrl = @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php";// 交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
    NSString *tradeType = @"APP";                                       //交易类型
    //获取SIGN签名
    TDWXPaySignAdaptor *adaptor = [[TDWXPaySignAdaptor alloc] initWithWechatAppId:TDWechatAPPID
                                                                        wechatMCHId:TDWechatMCHID
                                                                            tradeNo:tradeNO
                                                                   wechatPartnerKey:TDWechatPartnerKey
                                                                           payTitle:tradeTitle
                                                                            orderNo:orderNo
                                                                           totalFee:totalFee
                                                                           deviceIp:addressIP
                                                                          notifyUrl:notifyUrl
                                                                          tradeType:tradeType];

    //转换成XML字符串,这里只是形似XML，实际并不是正确的XML格式，需要使用AF方法进行转义
    NSString *xmlString = [[adaptor dic] XMLString];
    
    return xmlString;
}


#pragma mark ----查询订单签名转化为XML格式(查询支付结果时候,订单号必须是真实存在且支付过的)
- (NSString *)query_payParametersSetOrderNO:(NSString *)orderNO
{
   
    //============================================================
    // 支付流程实现 查询支付结果
    // 客户端操作     (实际操作应由服务端操作)
    //============================================================
    NSString *tradeNO   =[self dw_getNonce_str];                       //随机字符串变量 这里最好使用和安卓端一致的生成逻辑
                                     //交易类型
    //获取SIGN签名
    TDWXPaySignAdaptor *Adaptor =[[TDWXPaySignAdaptor alloc] init];
    NSDictionary *dic = [Adaptor queryWithWechatAppId:TDWechatAPPID wechatMCHId:TDWechatMCHID wechatPartnerKey:TDWechatPartnerKey tradeNo:tradeNO orderNo:orderNO];
    
    //转换成XML字符串,这里只是形似XML，实际并不是正确的XML格式，需要使用AF方法进行转义
    NSString *xmlString = [dic XMLString];
    
    return xmlString;

}



#pragma mark ---发送支付网络请求----
- (void)get_requestType:(RequestType)requestType withXml:(NSString*)xml backResp:(void(^)(BaseResp *backResp))backResp backCode:(void(^)(NSString *backCode))backCode return_ErrorCode:(void(^)(NSString *return_msg, NSString *err_code, NSString *err_code_des))return_ErrorCode backTrade_stateMsg:(void(^)(NSString *backTrade_stateMsg, NSString *backTrade_state))backTrade_stateMsg
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    // 这里传入的XML字符串只是形似XML，但不是正确是XML格式，需要使用AF方法进行转义
    session.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [session.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [session.requestSerializer setValue:requestType ==wxPay ? TDUrlWechatPay :TDUrlWechatQuery forHTTPHeaderField:@"SOAPAction"];
    [session.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return xml;
    }];
    
    [session POST:requestType ==wxPay ? TDUrlWechatPay :TDUrlWechatQuery
       parameters:xml
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
        NSLog(@"%@------",responseObject);
        NSLog(@"%@",requestType ==wxPay ? TDUrlWechatPay :TDUrlWechatQuery);
        //  输出XML数据
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] ;
        //  将微信返回的xml数据解析转义成字典
        NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
         DWWXPaySuccessModels *paySuccessModels = [DWWXPaySuccessModels wxPaySuccessWithDictionary:dic];
        
        if ([paySuccessModels.return_code isEqualToString:@"SUCCESS"]) {  //付款请求成功
            
            if ([paySuccessModels.result_code isEqualToString:@"SUCCESS"]) {
                
                if (requestType == wxOrderquery) {
                    
                    if ([paySuccessModels.trade_state isEqualToString:@"SUCCESS"]) {
                        
                        [self backTrade_stateMsg:@"支付成功" backTrade_state:paySuccessModels.trade_state];
                        
                    }else if ([paySuccessModels.trade_state isEqualToString:@"REFUND"]) {
                        
                        [self backTrade_stateMsg:@"转入退款" backTrade_state:paySuccessModels.trade_state];
                        
                    }else if ([paySuccessModels.trade_state isEqualToString:@"NOTPAY"]) {
                        
                        [self backTrade_stateMsg:@"未支付" backTrade_state:paySuccessModels.trade_state];
                        
                    }else if ([paySuccessModels.trade_state isEqualToString:@"CLOSED"]) {
                        
                        [self backTrade_stateMsg:@"已关闭" backTrade_state:paySuccessModels.trade_state];
                        
                    }else if ([paySuccessModels.trade_state isEqualToString:@"REVOKED"]) {
                        
                        [self backTrade_stateMsg:@"用户支付中" backTrade_state:paySuccessModels.trade_state];
                        
                    }else if ([paySuccessModels.trade_state isEqualToString:@"PAYERROR"]) {
                        
                        [self backTrade_stateMsg:@"支付失败(其他原因，如银行返回失败)" backTrade_state:paySuccessModels.trade_state];
                    }
                    
                    return ;
                }
                
            }else {
                
                if (self.Return_ErrorCode) {
                    
                    NSString *err_code_des;
                    
                    if ([paySuccessModels.err_code isEqualToString:@"ORDERNOTEXIST"]) {
                        
                        err_code_des = @"此交易订单号不存在\n该API只能查提交支付交易返回成功的订单，请商户检查需要查询的订单号是否正确";
                        
                    }else if ([paySuccessModels.err_code isEqualToString:@"SYSTEMERROR"]) {
                        
                        err_code_des = @"系统错误\n系统异常，请再调用发起查询";
                    }
                    
                    self.Return_ErrorCode(paySuccessModels.return_msg,paySuccessModels.err_code,err_code_des);
                    
                    return;
                }
            }
            
            
            PayReq *request = [[PayReq alloc] init];
            request.openID = paySuccessModels.appid;
            request.partnerId = paySuccessModels.mch_id;
            request.prepayId= paySuccessModels.prepay_id;
            request.package = @"Sign=WXPay";
            request.nonceStr= [NSString dw_getNonce_str];
            //获取时间戳
            time_t now;
            time(&now);
            request.timeStamp = (UInt32)[[NSString stringWithFormat:@"%ld", now] integerValue];
            // 签名加密
            TDWXPaySignAdaptor *md5 = [[TDWXPaySignAdaptor alloc] init];
            
            request.sign=[md5 createMD5SingForPay:request.openID
                                        partnerid:request.partnerId
                                         prepayid:request.prepayId
                                          package:request.package
                                         noncestr:request.nonceStr
                                        timestamp:request.timeStamp];
            //发起支付请求
            [WXApi sendReq:request];
            
        }
        else if(![paySuccessModels.return_code isEqualToString:@"SUCCESS"]){  //返回付款错误信息
            
            if (self.Return_ErrorCode) {
                
                self.Return_ErrorCode(paySuccessModels.return_msg,
                                      paySuccessModels.err_code,
                                      paySuccessModels.err_code_des);
            }
        }
        
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
     }];

#pragma mark ---微信返回结果
    self.BackCode = ^(NSString *code){
        backCode(code);
    };
    
#pragma mark ---微信返回内容
    self.BackResp = ^(BaseResp *resp) {
        backResp(resp);
    };
    
#pragma mark ---微信返回的错误信息
    self.Return_ErrorCode = ^(NSString *msg, NSString *code, NSString *codeMsg) {
        return_ErrorCode(msg,code,codeMsg);
    };
    
#pragma mark ---微信返回的交易订单状态信息
    self.BackTrade_stateMsg = ^(NSString *trade_stateMsg, NSString *trade_state) {
        
        backTrade_stateMsg(trade_stateMsg, trade_state);
    };
    
}


#pragma mark ---微信返回结果
- (void)backCode:(NSString *)backCode {
    if (self.BackCode) {
        self.BackCode(backCode);
    }
}

#pragma mark ---微信返回的交易订单状态信息
- (void)backTrade_stateMsg:(NSString *)backTrade_stateMsg backTrade_state:(NSString *)backTrade_state{
    
    if (self.BackTrade_stateMsg) {
        
        self.BackTrade_stateMsg(backTrade_stateMsg, backTrade_state);
        
    }
    
}

#pragma mark ---Delegate-----
//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp {
    //微信返回内容
    if (self.BackResp) {
        
        self.BackResp(resp);
    }
    
    //启动微信支付的response
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        PayResp *response=(PayResp*)resp;
        
        switch(response.errCode){
            case WXSuccess:
                
                [self backCode:@"支付成功"];
                
                break;
                
            case WXErrCodeUserCancel:
                
                [self backCode:@"用户取消"];
                
                break;
                
            case WXErrCodeSentFail:
                
                [self backCode:@"发送失败"];
                
                break;
                
            case WXErrCodeAuthDeny:
                
                [self backCode:@"授权失败"];
                
                break;
                
            case WXErrCodeUnsupport:
                
                [self backCode:@"微信不支持"];
                
                break;
                
            default:
        
                break;
        }
    }
}


#pragma mark - Private Method
/**
 ------------------------------
 产生随机字符串
 ------------------------------
 1.生成随机数算法 ,随机字符串，不长于32位
 2.微信支付API接口协议中包含字段nonce_str，主要保证签名不可预测。
 3.我们推荐生成随机数算法如下：调用随机数函数生成，将得到的值转换为字符串。
 */
#pragma mark ---获取随机数-----
- (NSString *)dw_getNonce_str
{
    NSArray *sourceStr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",
                           @"U",@"V",@"W",@"X",@"Y",@"Z"];
    NSString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < 32; i ++) {
        int value = arc4random() % 32;
        resultStr = [resultStr stringByAppendingString:[NSString stringWithFormat:@"%@",sourceStr[value]]];
    }
    return [NSString stringWithString:resultStr];
}

/**
 ------------------------------
 获取设备ip地址
 ------------------------------
 1.貌似该方法获取ip地址只能在wifi状态下进行
 */
#pragma mark ---获取客户端当前IP地址
- (NSString *)dw_getIPAddress {
    
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE =4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len =sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP =@"";
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count >0)
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

@end
