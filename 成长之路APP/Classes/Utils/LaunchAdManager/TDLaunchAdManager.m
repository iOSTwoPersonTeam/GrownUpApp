//
//  TDLaunchAdManager.m
//  成长之路APP
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDLaunchAdManager.h"
#import "XHLaunchAd.h"
#import "TDLaunchAdModel.h"

//静态图
#define imageURL1 @"http://c.hiphotos.baidu.com/image/pic/item/4d086e061d950a7b78c4e5d703d162d9f2d3c934.jpg"
#define imageURL2 @"http://d.hiphotos.baidu.com/image/pic/item/f7246b600c3387444834846f580fd9f9d72aa034.jpg"
#define imageURL3 @"http://d.hiphotos.baidu.com/image/pic/item/64380cd7912397dd624a32175082b2b7d0a287f6.jpg"
#define imageURL4 @"http://d.hiphotos.baidu.com/image/pic/item/14ce36d3d539b60071473204e150352ac75cb7f3.jpg"

//动态图
#define imageURL5 @"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg"
#define imageURL6 @"http://p1.bqimg.com/567571/4ce1a4c844b09201.gif"
#define imageURL7 @"http://p1.bqimg.com/567571/23a4bc7a285c1179.gif"

//视频链接
#define videoURL1 @"http://ohnzw6ag6.bkt.clouddn.com/video0.mp4"
#define videoURL2  @"http://120.25.226.186:32812/resources/videos/minion_01.mp4"
#define videoURL3 @"http://ohnzw6ag6.bkt.clouddn.com/video1.mp4"

@interface TDLaunchAdManager()<XHLaunchAdDelegate>

@end

static TDLaunchAdManager *_AdManager = nil;

@implementation TDLaunchAdManager

#pragma mark ----通过通知事件直接加载广告的方法
//+(void)load
//{
//    [self shareManager];
//}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//
//        //在UIApplicationDidFinishLaunching时初始化开屏广告
//        //当然你也可以直接在AppDelegate didFinishLaunchingWithOptions中初始化
//        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//
//            //初始化开屏广告
//            [self setupXHLaunchAd];
//
//        }];
//    }
//    return self;
//}


#pragma mark --单例的实现----
+(TDLaunchAdManager *)shareManager{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        _AdManager = [[TDLaunchAdManager alloc] init];
    });
    return _AdManager;
}

/*
 初始化内存管理
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_AdManager ==nil) {
            _AdManager =[super allocWithZone:zone];
        }
    });
    return _AdManager;
}


#pragma mark --添加视频或图片广告
-(void)setupXHLaunchAd
{
    //1.图片开屏广告 ---- 网络数据------
//    [self launchAdImageUrl];
    
    //2.视频开屏广告---网络请求数据-----
    [self launchAdVideoUrl];

}

#pragma mark ---预先下载视频或图片
-(void)downLoadVideoAndImageWithURL
{
    //3.如果你想提前缓存图片/视频请调下面这两个接口--------
    // 批量缓存图片
    [XHLaunchAd downLoadImageAndCacheWithURLArray:@[[NSURL URLWithString:imageURL1],[NSURL URLWithString:imageURL2],[NSURL URLWithString:imageURL3]]];
    // 批量缓存视频
    [XHLaunchAd downLoadVideoAndCacheWithURLArray:@[[NSURL URLWithString:videoURL1],[NSURL URLWithString:videoURL2],[NSURL URLWithString:videoURL3]]];
}



#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)launchAdImageUrl
{
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将自动进入window的RootVC
    //3.数据获取成功,初始化广告时,自动结束等待,显示广告
    [XHLaunchAd setWaitDataDuration:3];//请求广告数据前,必须设置,否则会先进入window的RootVC

    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    NSString *url =@"http://tishengtestapi.51ts.cn/common/findPubobjectList.do";
    //调用请求方法  GET请求
    [manager GETDataWithURL:url parameters:nil succeed:^(id responseObject) {

        NSLog(@"广告数据 = %@",responseObject);
        
        NSDictionary *dic =@{@"content":imageURL5,
                                   @"duration":@"6",
                                   @"contentSize":@"SCREEN_WIDTH *SCREEN_HEIGHT",
                                   @"openUrl":@"https://github.com/CoderZhuXH/XHLaunchAd"
                                   
                                   };
        //广告数据转模型
        TDLaunchAdModel *model = [[TDLaunchAdModel alloc] initWithDict:dic];
        //配置广告数据
        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
        //广告停留时间
        imageAdconfiguration.duration = model.duration;
        //广告frame
        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/model.width*model.height);
        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
        imageAdconfiguration.imageNameOrURLString = model.content;
        //缓存机制(仅对网络图片有效)
        //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
        //图片填充模式
        imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
        //广告点击打开链接
        imageAdconfiguration.openURLString = model.openUrl;
        //广告显示完成动画
        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
        //广告显示完成动画时间
        imageAdconfiguration.showFinishAnimateTime = 0.8;
        //跳过按钮类型
        imageAdconfiguration.skipButtonType = SkipTypeTimeText;
        //后台返回时,是否显示广告
        imageAdconfiguration.showEnterForeground = NO;
        
        //图片已缓存 - 显示一个 "已预载" 视图 (可选)
        if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]])
        {
            //设置要添加的自定义视图(可选)
            imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
            
        }
        //显示开屏广告
        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        
    } failure:^(NSError *error) {
        
        NSLog(@"失败-----%@",error);
    }];
    
}

#pragma mark - 视频开屏广告-网络数据-
//视频开屏广告 - 网络数据
-(void)launchAdVideoUrl
{
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将自动进入window的RootVC
    //3.数据获取成功,初始化广告时,自动结束等待,显示广告
    [XHLaunchAd setWaitDataDuration:3];//请求广告数据前,必须设置,否则会先进入window的RootVC
    
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    NSString *url =@"http://tishengtestapi.51ts.cn/common/findPubobjectList.do";
    //调用请求方法  GET请求
    [manager GETDataWithURL:url parameters:nil succeed:^(id responseObject) {
        
        NSLog(@"广告数据 = %@",responseObject);
        
        NSDictionary *dic =@{@"content":videoURL1,
                             @"duration":@"6",
                             @"contentSize":@"SCREEN_WIDTH *SCREEN_HEIGHT",
                             @"openUrl":@"https://github.com/CoderZhuXH/XHLaunchAd"
                             
                             };
        //广告数据转模型
        TDLaunchAdModel *model = [[TDLaunchAdModel alloc] initWithDict:dic];
        //配置广告数据
        XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
        //广告停留时间
        videoAdconfiguration.duration = model.duration;
        //广告frame
        videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/model.width*model.height);
        //广告视频URLString/或本地视频名(请带上后缀)
        //注意:视频广告只支持先缓存,下次显示
        videoAdconfiguration.videoNameOrURLString = model.content;
        //视频缩放模式
        videoAdconfiguration.scalingMode = MPMovieScalingModeAspectFill;
        //广告点击打开链接
        videoAdconfiguration.openURLString = model.openUrl;
        //广告显示完成动画
        videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
        //广告显示完成动画时间
        videoAdconfiguration.showFinishAnimateTime = 0.8;
        //后台返回时,是否显示广告
        videoAdconfiguration.showEnterForeground = NO;
        //跳过按钮类型
        videoAdconfiguration.skipButtonType = SkipTypeTimeText;
        //视频已缓存 - 显示一个 "已预载" 视图 (可选)
        if([XHLaunchAd checkVideoInCacheWithURL:[NSURL URLWithString:model.content]])
        {
            //设置要添加的自定义视图(可选)
            videoAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
            
        }
        
        [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
        
    } failure:^(NSError *error) {
        
        NSLog(@"失败-----%@",error);
    }];
    
}






#pragma mark - subViews
-(NSArray<UIView *> *)launchAdSubViews_alreadyView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, 30, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

#pragma mark - customSkipView
//自定义跳过按钮
-(UIView *)customSkipView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor orangeColor];
    button.layer.cornerRadius = 5.0;
    button.layer.borderWidth = 1.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100,30, 85, 40);
    [button addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
//跳过按钮点击事件
-(void)skipAction
{
    [XHLaunchAd skipAction];
}
#pragma mark - XHLaunchAd delegate - 倒计时回调
/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration
{
    //设置自定义跳过按钮时间
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    //设置时间
    [button setTitle:[NSString stringWithFormat:@"自定义%lds",duration] forState:UIControlStateNormal];
    
    if (duration ==0) {  //倒计时到0秒时候 直接进行下面操作
        
        if (self.launchShowFinishBlock) {
            self.launchShowFinishBlock();
        }
    }
    
}
#pragma mark - XHLaunchAd delegate - 其他

/**
 *  广告点击事件 回调
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString;
{
    NSLog(@"广告点击");
    TDRootWebViewController *webVC = [[TDRootWebViewController alloc] init];
    webVC.urlString = openURLString;
    //此处不要直接取keyWindow
    [((TDAppDelegate*)[UIApplication sharedApplication].delegate).rootViewController.navigationController pushViewController:webVC animated:YES];
}
/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param image    image
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image
{
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}
/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL
{
    NSLog(@"video下载/加载完成/保存path = %@",pathURL.absoluteString);
}

/**
 *  视频下载进度回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current
{
    NSLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
    
}

/**
 *  广告显示完成
 */
-(void)xhLaunchShowFinish:(XHLaunchAd *)launchAd
{
    NSLog(@"广告显示完成");
    
}



/**
 如果你想用SDWebImage等框架加载网络广告图片,请实现此代理
 
 @param launchAd          XHLaunchAd
 @param launchAdImageView launchAdImageView
 @param url               图片url
 */
//-(void)xhLaunchAd:(XHLaunchAd *)launchAd launchAdImageView:(UIImageView *)launchAdImageView URL:(NSURL *)url
//{
//    [launchAdImageView sd_setImageWithURL:url];
//
//}

@end
