//
//  TDUserInfo.m
//  成长之路APP
//
//  Created by mac on 2017/8/14.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDUserInfo.h"

@implementation TDUserModel

@end


@implementation TDUserInfo

//文件路径
+ (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"userInfo.plist"];
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:filePath] )
    {
        [fileManger createFileAtPath:filePath contents:nil attributes:nil];
    }
    return filePath;
}

//读取文件
+ (NSMutableDictionary *)getFileInfo
{
    NSString *filePath = [self filePath];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithContentsOfFile:filePath]];
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
    }
    return  dic;
}

//保存用户信息
+ (BOOL)saveUserInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary *dic = [self getFileInfo];
    [userInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         if (![obj isEqual:[NSNull null]])
         {
             [dic setObject:obj forKey:key];
         }
     }];
    
    NSString *filepath = [self filePath];
    return [dic writeToFile:filepath atomically:NO];
}

//获取用户信息
+ (TDUserModel *)getUser
{
    NSMutableDictionary *dic =[self getFileInfo];
    return [TDUserModel mj_objectWithKeyValues:dic];;
}

+ (BOOL)removeUserInfo
{
    NSString *filepath = [self filePath];
    return [@{} writeToFile:filepath atomically:NO];
}


@end
