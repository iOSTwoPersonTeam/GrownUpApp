//
//  TDHomeLiveStreamingViewController.m
//  成长之路APP
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeLiveStreamingViewController.h"
#import "EaseLiveViewController.h"
#import "EasePublishViewController.h"

@interface TDHomeLiveStreamingViewController ()

@property(nonatomic, strong)MarqueeLabel *rollWordLabel; //滚动文字
@property(nonatomic, strong)UIButton *publishButton; //发布直播按钮

@end

@implementation TDHomeLiveStreamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.rollWordLabel];
    [self.view addSubview:self.publishButton];
    
    NSString *markString =@"环信+UCould直播,这里只提供简单的几个账号.15712860261是发布直播账号,观看直播只要任意输入账号即可,点击view页面即可进入观看直播,还有因为没有服务器创建聊天室,因此这里的聊天室是在pc端自己创建的(暂时固定)………………";
    self.rollWordLabel.text =markString;
}


#pragma mark --action
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DLog(@"观看直播-----");
    //EaseLiveRoom
    /*
     room.session.mobilepullstream =@"rtmp://vlive3.rtmp.cdn.ucloud.com.cn/ucloud/easemob-demo_chatdemoui_3493_1";
     room.session.mobilepushstream =@"rtmp://publish3.cdn.ucloud.com.cn/ucloud/easemob-demo_chatdemoui_3493_1";
     */
    EaseLiveRoom *room =[[EaseLiveRoom alloc] init];
    room.roomId =@"3493";
    room.chatroomId =@"31132493086721";
    //拉流Id
    NSString *Id = [NSString stringWithFormat:@"Tidoo_%@",@"15712860261"];
    room.session.mobilepullstream = PlayDomain(Id);
    EaseLiveViewController *view = [[EaseLiveViewController alloc] initWithLiveRoom:room];
    [self.navigationController presentViewController:view animated:YES completion:NULL];
}

-(void)clickPublish
{
    DLog(@"发布直播------");
    //创建聊天室的方法
    
    //EaseLiveRoom
    /*
     room.session.mobilepullstream =@"rtmp://vlive3.rtmp.cdn.ucloud.com.cn/ucloud/easemob-demo_chatdemoui_3493_1";
     room.session.mobilepushstream =@"rtmp://publish3.cdn.ucloud.com.cn/ucloud/easemob-demo_chatdemoui_3493_1";
     */
    EaseLiveRoom *room =[[EaseLiveRoom alloc] init];
    room.roomId =@"3493";
    room.chatroomId =@"31132493086721";
    //推流Id
    NSString *Id = [NSString stringWithFormat:@"Tidoo_%@",[TDUserInfo getUser].UCODE];
    room.session.mobilepushstream = RecordDomain(Id);
    EasePublishViewController *publishView = [[EasePublishViewController alloc] initWithLiveRoom:room];
    [self presentViewController:publishView animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}




#pragma mark --getter
-(MarqueeLabel *)rollWordLabel
{
    if (!_rollWordLabel) {
        _rollWordLabel =[[MarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _rollWordLabel.backgroundColor =[UIColor whiteColor];
        _rollWordLabel.font =[UIFont systemFontOfSize:15];
        _rollWordLabel.textColor =[UIColor lightGrayColor];
        _rollWordLabel.marqueeType =MLContinuous;
        _rollWordLabel.animationCurve =UIViewAnimationOptionCurveLinear;
        _rollWordLabel.userInteractionEnabled =YES;
        _rollWordLabel.rate =70;
        _rollWordLabel.fadeLength =10;
    }
    return _rollWordLabel;
}

-(UIButton *)publishButton
{
    if (!_publishButton) {
        _publishButton =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, SCREEN_HEIGHT/2, 80, 80)];
        _publishButton.backgroundColor =[UIColor orangeColor];
        [_publishButton setTitle:@"发布直播" forState:UIControlStateNormal];
        _publishButton.titleLabel.font =[UIFont systemFontOfSize:14];
        _publishButton.layer.masksToBounds =YES;
        _publishButton.layer.cornerRadius =40;
        [_publishButton addTarget:self action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}


@end
