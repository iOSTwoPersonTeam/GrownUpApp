//
//  TDHomeDetailViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeDetailViewController.h"
#import "TDRootModel.h"
#import "TDRootTableViewCell.h"

@interface TDHomeDetailViewController ()
{

    TDBaseRequestApI *_manager;
}


@end

@implementation TDHomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emptyDataEnabled = YES;
    self.refreshEnabled = YES;
    
    CGRect frame =self.tableView.frame;
    frame.size.height -=44;
    self.tableView.frame =frame;

    self.loadModel.allItems =[NSMutableArray arrayWithArray:@[@"dsgds",@" gdgdsf",@"第三个发多少",@"发多少公司",@"的身高多少"]];
}

-(Class)tableCellClass
{
    
    return  [UITableViewCell class];
}


#pragma mark --UITableViewDataSource, UITableViewDelagate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self tableCellClass]) forIndexPath:indexPath];
    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.backgroundColor =[UIColor redColor];
    
    cell.textLabel.text =self.loadModel.allItems[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    _manager =manager;
    NSString *url =@"http://apitest.51negoo.com/coupons/conditionList.do?appkey=peixunduoduo&coupons_id=486&sign=f6f4da0789e61740f59c28d93705f39a&timestamp=1499950328&ucode=df7ea90a339011e7b37b00163e068794";

#pragma mark ---GET请求接口
    //调用请求方法  GET请求
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:@"1" forKey:@"nnn"];
    [manager GETDataWithURL:url parameters:nil succeed:^(id data) {
        
        NSLog(@"成功------%@",data);
        
    } failure:^(NSError *error) {
        
        NSLog(@"失败-----%@",error);
    }];

#pragma mark ---POST请求接口
    //调用请求方法  POST请求
//    [manager POSTDataWithURL:url parameters:nil succeed:^(id data) {
//        
//        NSLog(@"成功------%@",data);
//    } failure:^(NSError *error) {
//        
//        NSLog(@"失败------%@",error);
//    }];
    
    
#pragma mark ---下载接口
//    url =@"http://videoo.51negoo.com/ios_62980495123919851.mp4";
//    //调用下载方法 Down
//    [manager DownloadWithURL:url progress:^(float progress) {
//        
//        NSLog(@"进度---%f",progress);
//        if (progress >0.5) {
//            
//            [self suspend];
//        }
//
//        
//        
//    } success:^(id data) {
//        
//        NSLog(@"成功---%@",data);
//    } failure:^(NSError *error) {
//        
//        NSLog(@"失败---%@",error);
//    }];

#pragma mark ---上传接口
    //上传接口------
//     NSDictionary *dict = @{@"appkey":@"peixunduoduo",@"clubsid":@"1368",@"name":@"1234567",@"sign":@"bde332352734f1a3c3129d05158e869b",@"timestamp":@"1501812331",@"ucode":@"e93ae7663f6d11e6b99b00163e001341"};
//    url =@"http://tishengtestapi.51ts.cn/clubs/addClubsIcons.do";
//    FormData *fData =[[FormData alloc] init];
//    UIImage *image =[UIImage imageNamed:@"app"];
//    fData.data =UIImagePNGRepresentation(image);
//    fData.name =@"image";
//    fData.mimeType =@"image/png";
//    
//    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//    // 要解决此问题，
//    // 可以在上传时使用当前的系统事件作为文件名
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    // 设置时间格式
//    formatter.dateFormat = @"yyyyMMddHHmmss";
//    NSString *str = [formatter stringFromDate:[NSDate date]];
//    fData.filename = [NSString stringWithFormat:@"%@.png", str];
//    
//    //上传方法
//    
//    [manager UploadWithURL:url params:dict formDataArray:@[fData] progress:^(float progress) {
//        // 回到主队列刷新UI,用户自定义的进度条
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
//        NSLog(@"进度---%f",progress);
//    } success:^(id data) {
//        
//        NSLog(@"成功----%@",data);
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"失败----%@",error);
//    }];
    
    
}

-(void)suspend
{
    //暂停下载
    [_manager taskPause];
    
    [NSTimer timerWithTimeInterval:1.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        
        [self susume];
    }];

}


-(void)susume
{//继续下载
    [_manager taskPause];

}








#pragma mark -----DZNEmptyDataSet

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:@"该分类下还没有可用的服务哦!\n快去联系客服吧" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16] ,NSForegroundColorAttributeName : [UIColor grayColor]}];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"img"];
}




@end






