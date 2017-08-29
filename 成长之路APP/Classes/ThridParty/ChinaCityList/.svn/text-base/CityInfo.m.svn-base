//
//  CityInfo.m
//  ShanDan
//
//  Created by 郑少博 on 16/12/30.
//  Copyright © 2016年 郑少博. All rights reserved.
//

#import "CityInfo.h"


NSInteger cityNameSort(CityItem *str1, CityItem *str2, void *context)
{
    NSString *string1 = str1.name;
    NSString *string2 = str2.name;
    
    return  [string1 localizedCompare:string2];
}

@implementation CityInfo

//文件路径
+ (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"cityInfo.plist"];
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:filePath] )
    {
        [fileManger createFileAtPath:filePath contents:nil attributes:nil];
    }
    return filePath;
}

//读取文件
+ (NSMutableArray *)getFileInfo
{
    NSString *filePath = [self filePath];
    NSMutableArray *dic = [NSMutableArray arrayWithContentsOfFile:filePath];
    if (!dic) {
        dic = [NSMutableArray array];
    }
    return  dic;
}

//保存城市信息
+ (BOOL)saveCityInfo:(NSArray *)userInfo
{
    NSMutableArray *dic = [self getFileInfo];
    [dic removeAllObjects];
    [dic addObjectsFromArray:userInfo];
    NSString *filepath = [self filePath];
    return [dic writeToFile:filepath atomically:NO];
}

//获取城市信息
+ (NSArray<CityItem *> *)getCitys
{
    NSMutableArray *dic =[self getFileInfo];
    return [CityItem mj_objectArrayWithKeyValuesArray:dic];;
}

+ (BOOL)removeCityInfo
{
    NSString *filepath = [self filePath];
    return [[NSMutableArray array] writeToFile:filepath atomically:NO];
}

@end
