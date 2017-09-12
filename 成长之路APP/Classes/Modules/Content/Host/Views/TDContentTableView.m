//
//  TDContentTableView.m
//  成长之路APP
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDContentTableView.h"

@interface TDContentTableView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)NSArray *dataArray; //数组

@end

@implementation TDContentTableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.dataArray =@[@"看电视看的方法那倒是当升",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当",@"看电视看的方法那倒是当"];
        
    }
    return self;
}

#pragma mark ----布局--
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark ---private--




#pragma mark ---Delagate---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    static NSString *cellID = @"cellId";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor =[UIColor whiteColor];
    cell.textLabel.text =_dataArray[indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



#pragma mark----getter--







@end
