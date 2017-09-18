//
//  TDShareSDKTool.m
//  成长之路APP
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDShareSDKTool.h"

@interface TDShareSDKTool ()

@property(nonatomic,strong)NSMutableDictionary *shareParams;

@end

static TDShareSDKTool *_manager =nil;

@implementation TDShareSDKTool

#pragma mark --创建单例
/*
   创建请求管理者 单例形式
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


#pragma mark ---注册ShareSDK
-(void)registerShare
{
    
    /**初始化ShareSDK应用
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
                 
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
                 
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:TD_WeiChat_AppID
                                       appSecret:TD_WeiChat_AppSecret];
                 break;
                 
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:TD_QQ_AppId
                                      appKey:TD_QQ_AppKey
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:TD_Sina_AppKey
                                        appSecret:TD_Sina_AppSecret
                                         redirectUri:TD_Sina_RediRectUri
                                            authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];

}


#pragma mark --第三方登录
-(void)getUserInfoThirdLoginWithType:(SSDKPlatformType)type success:(void (^)(SSDKUser *user))succeed
                             failure:(void (^)(NSError *error))failure
{

    
    [ShareSDK cancelAuthorize:type];
    
    [ShareSDK getUserInfo:type onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        switch (state) {
            case SSDKResponseStateSuccess:{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                succeed(user);
            });
                
            }
                break;
            case SSDKResponseStateFail:{ 
                    failure(error);
            }
                break;
            default:
                break;
        }
     }];

}


#pragma mark --第三方分享(SDK自带UI)
-(void)shareSystemUIWithContentURL:(NSString *)contentURLString andcontentTitle:(NSString*)contentTitle contentDescription:(NSString *)contentDescription contentImage:(NSString *)contentImage success:(void(^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{

    //URL
    NSString *urlString = contentURLString;
    //分享标题
    NSString *string = [NSString stringWithFormat:@"%@",contentTitle];
    if (string.length >= 40) {
        string = [string substringToIndex:40];
    }
    //分享内容
    NSString *desString = [NSString stringWithFormat:@"%@",contentDescription];
    if (desString.length >= 130) {
        desString = [desString substringToIndex:130];
    }
    //图片
    NSArray* imageArray = @[contentImage];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKEnableUseClientShare];
        [shareParams SSDKSetupShareParamsByText:contentDescription
                                         images:contentImage
                                            url:[NSURL URLWithString:contentURLString]
                                          title:contentTitle
                                           type:SSDKContentTypeAuto];
        // 定制新浪微博的分享内容
        [shareParams SSDKSetupSinaWeiboShareParamsByText:contentDescription title:string image:contentImage url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
        // 定制微信好友的分享内容
        [shareParams SSDKSetupWeChatParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];// 微信好友子平台
        // 定制微信朋友圈的分享内容
        [shareParams SSDKSetupWeChatParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];// 微信好友子平台
        // 定制微信收藏的分享内容
        [shareParams SSDKSetupWeChatParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatFav];// 微信好友子平台
        //定制QQ空间的分享内容
        [shareParams SSDKSetupQQParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQZone];
        //定制QQ好友的分享内容
        [shareParams SSDKSetupQQParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        __weak typeof(self) unself=self;
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                            items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               
                               success(userData);
                               
                               if(platformType ==  SSDKPlatformSubTypeWechatFav) {
                                   
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"收藏成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                               } else{
                                   
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   
                                   
                               }
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               failure(error);
                               
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
           ];

    }
    

}

#pragma mark ---第三方分享 自定义UI的实现
-(void)shareCustomUIWithContentURL:(NSString *)contentURLString andcontentTitle:(NSString *)contentTitle contentDescription:(NSString *)contentDescription contentImage:(NSString *)contentImage success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{

    //URL
    NSString *urlString = contentURLString;
    //分享标题
    NSString *string = [NSString stringWithFormat:@"%@",contentTitle];
    if (string.length >= 40) {
        string = [string substringToIndex:40];
    }
    //分享内容
    NSString *desString = [NSString stringWithFormat:@"%@",contentDescription];
    if (desString.length >= 130) {
        desString = [desString substringToIndex:130];
    }
    //图片
    NSArray* imageArray = @[contentImage];
    
    if (imageArray) {
        
        [self.shareParams SSDKEnableUseClientShare];
        [self.shareParams SSDKSetupShareParamsByText:contentDescription
                                         images:contentImage
                                            url:[NSURL URLWithString:contentURLString]
                                          title:contentTitle
                                           type:SSDKContentTypeAuto];
        // 定制新浪微博的分享内容
        [_shareParams SSDKSetupSinaWeiboShareParamsByText:contentDescription title:string image:contentImage url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
        // 定制微信好友的分享内容
        [_shareParams SSDKSetupWeChatParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];// 微信好友子平台
        // 定制微信朋友圈的分享内容
        [_shareParams SSDKSetupWeChatParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];// 微信好友子平台
        // 定制微信收藏的分享内容
        [_shareParams SSDKSetupWeChatParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatFav];// 微信好友子平台
        //定制QQ空间的分享内容
        [_shareParams SSDKSetupQQParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQZone];
        //定制QQ好友的分享内容
        [_shareParams SSDKSetupQQParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQQFriend];
        //复制链接的分享内容
        [_shareParams SSDKSetupQQParamsByText:contentDescription title:contentTitle url:[NSURL URLWithString:contentURLString] thumbImage:nil image:contentImage type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformTypeCopy];
        
    }
    
    //创建自定义的UI样式
    [self createCustomUI];
  
        
}


-(void)createCustomUI{
    //将控件加到keyWindow上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //透明蒙层
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    grayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    grayView.tag = 1000;
    UITapGestureRecognizer *tapGrayView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelShareAction)];
    [grayView addGestureRecognizer:tapGrayView];
    grayView.userInteractionEnabled = YES;
    [window addSubview:grayView];
    //分享控制器
    UIView *shareBackView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3 *2 -40, SCREEN_WIDTH, SCREEN_HEIGHT/3 +40)];
    shareBackView.backgroundColor =[UIColor colorWithRed:1 green:1 blue:1 alpha:0.95];
    shareBackView.tag = 1001;
    [window addSubview:shareBackView];
    //分享标题提示语
    UILabel *shareTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    shareTipLabel.text = @"分享";
    shareTipLabel.textColor =[UIColor blackColor];
    shareTipLabel.textAlignment = NSTextAlignmentCenter;
    shareTipLabel.font = [UIFont systemFontOfSize:20];
    shareTipLabel.backgroundColor = [UIColor clearColor];
    [shareBackView addSubview:shareTipLabel];
    
    NSArray *imageArray =@[@"直播分享微信",@"直播分享朋友圈",@"直播分享微博",@"直播分享qq",@"直播分享qq空间",@"复制链接"];
    NSArray *titleArray =@[@"微信",@"朋友圈",@"微博",@"QQ好友",@"QQ空间",@"复制链接"];
    float buttonWith =60;
    float buttonheight =80;
    NSInteger lineNum =3;
    float spaceX =(SCREEN_WIDTH-buttonWith*lineNum)/(lineNum +1);
    for (int i=0; i <imageArray.count; i++) {
        
        float pointX = (i%lineNum +1)* spaceX +buttonWith *(i%lineNum);
        float pointY =(buttonheight +10) *(i/lineNum) +CGRectGetMaxY(shareTipLabel.frame)+10;
        UIButton *imageButton =[[UIButton alloc] initWithFrame:CGRectMake(pointX ,pointY , buttonWith, buttonheight)];
        [imageButton setTitle:titleArray[i] forState:UIControlStateNormal];
        imageButton.titleLabel.font =[UIFont systemFontOfSize:12];
        [imageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [imageButton setImage:[UIImage SizeImage:imageArray[i] toSize:CGSizeMake(buttonWith, buttonWith)] forState:UIControlStateNormal];
        [imageButton setImagePosition:ImageAndTitlePositionTop WithImageAndTitleSpacing:10];
        imageButton.tag =1005 +i;
        [imageButton addTarget:self action:@selector(dicClickPlatformButton:) forControlEvents:UIControlEventTouchUpInside];
        [shareBackView addSubview:imageButton];
    }

    //取消按钮
    UILabel *lineLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3 +5, SCREEN_WIDTH, 1)];
    lineLabel.backgroundColor =[UIColor whiteColor];
    [shareBackView addSubview:lineLabel];
    
    UIButton *cancelButton =[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineLabel.frame), SCREEN_WIDTH, 35)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBackView addSubview:cancelButton];
    
    [UIView animateWithDuration:0.5 animations:^{
        shareBackView.frame = CGRectMake(0, SCREEN_HEIGHT-shareBackView.frame.size.height, shareBackView.frame.size.width, shareBackView.frame.size.height);
    }];
    
}

-(void)dicClickPlatformButton:(UIButton *)button {
    //移除分享面板
    [self removeShareView];
    int shareType = 0;
    NSMutableDictionary *publishContent = _shareParams;
    switch (button.tag)
    {
        case 1005: {
            shareType =SSDKPlatformSubTypeWechatSession;
        }
        break;
        case 1006: {
            shareType = SSDKPlatformSubTypeWechatTimeline;
        }
        break;
        case 1007: {
            shareType = SSDKPlatformTypeSinaWeibo;
        }
        break;
        case 1008: {
            shareType = SSDKPlatformTypeQQ;
        }
        break;
        case 1009: {
            shareType = SSDKPlatformSubTypeQZone;
        }
        break;
        case 1010: {
            shareType = SSDKPlatformTypeCopy;
        }
        break;
        default:
        break;
    }
    /* 调用shareSDK的无UI分享类型 */
    [ShareSDK share:shareType parameters:publishContent onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess: {
                if (shareType == SSDKPlatformTypeCopy) {
                    NSLog(@"复制成功");
                }else{
                    NSLog(@"分享成功");
                }
                break;
                case SSDKResponseStateFail:
                if (shareType == SSDKPlatformTypeCopy) {
                    NSLog(@"复制失败");
                }else{
                    NSLog(@"分享失败");
                }
                NSLog(@"失败：%@", error);
                break;
                }
                default:
                break;
           }
    }];
}


    
-(void)removeShareView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow; UIView *blackView = [window viewWithTag:1000];
    UIView *shareView = [window viewWithTag:1001];
    shareView.frame =CGRectMake(0, shareView.frame.origin.y, shareView.frame.size.width, shareView.frame.size.height); [UIView animateWithDuration:0.5 animations:^{
        shareView.frame = CGRectMake(0, SCREEN_HEIGHT, shareView.frame.size.width, shareView.frame.size.height);
    } completion:^(BOOL finished) {
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
    }];
}


-(void)cancelShareAction{
    
    [self removeShareView];
}



-(NSMutableDictionary *)shareParams
{
    if (!_shareParams) {
        _shareParams =[NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _shareParams;
}





@end




