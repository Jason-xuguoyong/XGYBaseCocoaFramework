//
//  NSFileManager+HomeDocuentPath.h
//  RMTiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (HomeDocuentPath)

/**
 *  获取沙盒Document的路径
 */
+ (NSString *)getHomeDocumentPath;
/**
 *  在沙盒中创建一个文件夹
 *
 *  @param documentName 文件夹的名称
 *
 *  @return 返回文件夹路径
 */
+ (NSString *)createDocumentWithDocumentName:(NSString *)documentName;

/**
 *  获取离线缓存的数据的存放路径
 */
//+ (NSString *)getOfflineCacheSqlitePath;

/**
 *  在沙盒中创建一个文件
 *
 *  @param fileName 文件夹的名称
 *
 *  @return 返回文件夹路径
 */
+ (NSString *)createDocumentWithfileName:(NSString *)fileName;

/**
 *  获取离线缓存的数据在沙盒中的存放路径
 */
+ (NSString *)getOfflineCacheInDacomentPath;

/**
 创建缓存文件
 
 @param key 缓存文件key
 @return 返回文件路径
 */
+ (NSString *)CacheFileWithKey:(NSString *)key;
@end
