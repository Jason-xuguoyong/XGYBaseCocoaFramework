//
//  XGYHttp.h
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGYHttp : NSObject
/**
 *  发送一个GET请求 请求参数是Jason
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params isJason:(BOOL)isJason success:(void (^)(id responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;





/**
 *  发送一个Post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)post:(NSString *)url params:(NSDictionary *)params isJason:(BOOL)isJason success:(void (^)(id responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;



/**
 *  发送一个put请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)put:(NSString *)url params:(NSDictionary *)params isJason:(BOOL)isJason success:(void (^)(id responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


/**
 *  发送一个delect请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)delect:(NSString *)url params:(NSDictionary *)params isJason:(BOOL)isJason success:(void (^)(id responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


@end
