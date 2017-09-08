//
//  TDContentTableView.m
//  成长之路APP
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDContentTableView.h"

@interface TDContentTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TDContentTableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
    return 16;
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
    
    cell.backgroundColor =[UIColor orangeColor];
    cell.textLabel.text =@"大家好";
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



#pragma mark----getter--







@end
