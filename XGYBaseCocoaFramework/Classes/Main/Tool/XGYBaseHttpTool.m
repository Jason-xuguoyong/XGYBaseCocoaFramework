//
//  XGYBaseHttpTool.m
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "XGYBaseHttpTool.h"
#import "XGYHttp.h"
@implementation XGYBaseHttpTool
/**
 GET请求
 
 @param url       请求的服务器地址
 @param parma     请求参数 是一个字典
 @param showError 请求错误时是否需要显示后台的错误提示
 @param showHud   是否需要显示加载的loading图标
 @param tableView 当前刷新的TableView(主要是用于请求成功之后，停止上下拉刷新)可选
 @param success   请求成功之后会调用的回调方法 将请求结果返回
 @param failure   失败会走的回调
 */
+(void)getDataWithURL:(NSString *)url parma:(NSDictionary *)parma isJason:(BOOL)isJason showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud refreshTableView:(UITableView *)tableView success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{

    // 4 发起网络请求
    [XGYHttp get:url params:parma isJason:isJason success:^(id responseObj) {
        //处理数据回调
        dispatch_async(dispatch_get_main_queue(), ^{
            success(responseObj);
        });
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task,error);
        });
    }];

}

/**
 POST请求
 
 @param url       请求的服务器地址
 @param parma     请求参数 是一个字典
 @param showError 请求错误时是否需要显示后台的错误提示
 @param showHud   是否需要显示加载的loading图标
 @param tableView **** 当前刷新的TableView(主要是用于请求成功之后，停止上下拉刷新)可选字段
 @param success   请求成功之后会调用的回调方法 将请求结果返回
 @param failure   失败会走的回调
 */
+ (void)postDataWithURL:(NSString *)url parma:(NSDictionary *)parma isJason:(BOOL)isJason showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud refreshTableView:(UITableView *)tableView success:(void (^)(id responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure
{
    
    // 4 发起网络请求
    [XGYHttp post:url params:parma isJason:isJason success:^(id responseObj) {
        //处理数据回调
        dispatch_async(dispatch_get_main_queue(), ^{
            success(responseObj);
        });
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task,error);
        });
    }];
}


/**
 PUT请求
 
 @param url       请求的服务器地址
 @param parma     请求参数 是一个字典
 @param showError 请求错误时是否需要显示后台的错误提示
 @param showHud   是否需要显示加载的loading图标
 @param tableView **** 当前刷新的TableView(主要是用于请求成功之后，停止上下拉刷新)可选字段
 @param success   请求成功之后会调用的回调方法 将请求结果返回
 @param failure   失败会走的回调
 */
+ (void)putDataWithURL:(NSString *)url parma:(NSDictionary *)parma isJason:(BOOL)isJason showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud refreshTableView:(UITableView *)tableView success:(void (^)(id responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure
{
    // 4 发起网络请求
    [XGYHttp put:url params:parma isJason:isJason success:^(id responseObj) {
        //处理数据回调
        dispatch_async(dispatch_get_main_queue(), ^{
            success(responseObj);
        });
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task,error);
        });
    }];
}

/**
 delect请求
 
 @param url       请求的服务器地址
 @param parma     请求参数 是一个字典
 @param showError 请求错误时是否需要显示后台的错误提示
 @param showHud   是否需要显示加载的loading图标
 @param tableView **** 当前刷新的TableView(主要是用于请求成功之后，停止上下拉刷新)可选字段
 @param success   请求成功之后会调用的回调方法 将请求结果返回
 @param failure   失败会走的回调
 */
+ (void)delectDataWithURL:(NSString *)url parma:(NSDictionary *)parma isJason:(BOOL)isJason showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud refreshTableView:(UITableView *)tableView success:(void (^)(id responseObj))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure
{
    // 4 发起网络请求
    [XGYHttp delect:url params:parma isJason:isJason success:^(id responseObj) {
        //处理数据回调
        dispatch_async(dispatch_get_main_queue(), ^{
            success(responseObj);
        });
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task,error);
        });
    }];
}


@end
