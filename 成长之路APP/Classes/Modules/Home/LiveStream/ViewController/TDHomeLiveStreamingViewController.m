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

@property(nonatomic, strong)UIButton *publishButton; //发布直播按钮

@end

@implementation TDHomeLiveStreamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.publishButton];
    
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
-(UIButton *)publishButton
{
    if (!_publishButton) {
        _publishButton =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, SCREEN_HEIGHT/2, 60, 60)];
        _publishButton.backgroundColor =[UIColor orangeColor];
        [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
        _publishButton.layer.masksToBounds =YES;
        _publishButton.layer.cornerRadius =30;
        [_publishButton addTarget:self action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}


@end
