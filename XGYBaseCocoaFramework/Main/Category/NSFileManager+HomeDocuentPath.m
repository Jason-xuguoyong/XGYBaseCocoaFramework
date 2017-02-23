//
//  NSFileManager+HomeDocuentPath.m
//  RMTiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "NSFileManager+HomeDocuentPath.h"

@implementation NSFileManager (HomeDocuentPath)
/**
 *  获取沙盒Document的路径
 */
+ (NSString *)getHomeDocumentPath
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return doc;
}

/**
 *  在沙盒中创建一个文件夹
 *
 *  @param documentName 文件夹的名称
 *
 *  @return 返回文件夹路径
 */
+ (NSString *)createDocumentWithDocumentName:(NSString *)documentName
{
    
    
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", [self getHomeDocumentPath],documentName];
    
    BOOL result = NO;
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        
        result =   [[NSFileManager defaultManager] createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }else
    {
        result = YES;//已经存在
    }
    return result?createPath:nil;
}

/**
 *  在沙盒中创建一个文件
 *
 *  @param fileName 文件的名称
 *
 *  @return 返回文件夹路径
 */
+ (NSString *)createDocumentWithfileName:(NSString *)fileName
{
    
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", [self getHomeDocumentPath],fileName];
    
    BOOL result = NO;
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        
        result =   [[NSFileManager defaultManager] createFileAtPath:createPath contents:nil attributes:nil];
    }else
    {
        result = YES;//已经存在
    }
    return result?createPath:nil;
}


/**
 *  获取离线缓存的数据的存放路径
 */
+ (NSString *)getOfflineCacheSqlitePath
{
    NSString * sqliteDocument = [self createDocumentWithDocumentName:@"cacheSqlite"];
    NSString *sqlitePath = [NSString stringWithFormat:@"%@/cacheSqlite.sqlite",sqliteDocument];
    
    return sqlitePath;
}


/**
 *  获取离线缓存的数据在沙盒中的存放路径
 */
+ (NSString *)getOfflineCacheInDacomentPath
{
    NSString * Document = [self createDocumentWithDocumentName:@"CacheData"];

    
    return Document;
}


/**
 创建缓存文件

 @param key 缓存文件key
 @return 返回文件路径
 */
+ (NSString *)CacheFileWithKey:(NSString *)key
{
    //替换/
    NSString *path  =  [NSFileManager getOfflineCacheInDacomentPath];
    NSString *strPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",[key stringByReplacingOccurrencesOfString:@"/" withString:@"_"]]];
    
    return strPath;
}

@end
