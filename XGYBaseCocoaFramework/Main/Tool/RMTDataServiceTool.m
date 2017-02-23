//
//  RMTDataServiceTool.m
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "RMTDataServiceTool.h"
#import "RMTBaseHttpTool.h"


@implementation RMTDataServiceTool



#pragma mark ====请求成功之后的回调方法
/**
 请求成功时候的回调和处理UI
 
 @param responseObj 后台请求成功之后返回的数据
 @param success 成功的回调
 @param tableView 刷新的tableView
 @param isShowHUD 成功之后的回调
 */
+ (void)requestSuccessWithData:(id)responseObj Success:(void (^)(id responseObj))success refreshTableView:(UITableView *)tableView isShowHUD:(BOOL)isShowHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        success(responseObj);
    });
    
    [RMTDataServiceTool hiddenHUDAndNetworkActivityIndicatorVisible:tableView isShowHUD:isShowHUD];
    
}


#pragma mark ====请求失败之后的回调方法
/**
 请求失败的时候的处理方法和处理UI
 
 @param task 失败任务
 @param error 失败的原因
 @param failure 失败的回调
 */
+ (void)requestFaileWithErrorTask:(NSURLSessionDataTask *) task error:( NSError *)error failure:(void (^)(NSError *error,NSString *errorCode,NSString *remark))failure showError:(BOOL)showError refreshTableView:(UITableView *)tableView showHUD:(BOOL)showHud
{
    
    RMTDebugLog(@"error---%@",error);
     [RMTDataServiceTool hiddenHUDAndNetworkActivityIndicatorVisible:tableView isShowHUD:showHud];
    id data = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
    NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
    
    //先处理请求超时的情况
    if (error.code == -1001/*请求超时*/) {
        [RMTMessageTool showMessage:@"当前网络似乎不太给力~"];
        failure(error,[NSString stringWithFormat:@"%ld",(long)responses.statusCode], @"网络请求超时");
        return;
    }
    
    //如果不需要展示
    if (!showError) {
        failure(error,[NSString stringWithFormat:@"%ld",(long)responses.statusCode], @"网络请求超时");
        return;
        
    }
    
    
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString *meg = [dict objectForKey:@"description"]?[dict objectForKey:@"description"]:[dict objectForKey:@"message"];
        
        if (responses.statusCode == 401/*需要回到登录页面*/) {
            [RMTMessageTool showMessage:@"请先登录"];
        }else if(responses.statusCode == 400){
            [RMTMessageTool showMessage:meg];
        }else if(responses.statusCode == 404){
            [RMTMessageTool showMessage:[NSString stringWithFormat:@"服务器充电中..."]];
        }else if(responses.statusCode == 403){
            [RMTMessageTool showMessage:[NSString stringWithFormat:@"服务器上火星去啦~"]];
        }else if(responses.statusCode == 402){
            [RMTMessageTool showMessage:[NSString stringWithFormat:@"服务器迷路咯~"]];
        }else if(responses.statusCode == 500){
            [RMTMessageTool showMessage:@"我们的攻城狮正在拼命修复..."];
        }else if(responses.statusCode == 405){
            [RMTMessageTool showMessage:@"服务器找不到请求方向..."];
        }else
        {
            RMTDebugLog(@"请求失败，后台没有返回原因error=%@",error);
        }
        
        failure(error,[NSString stringWithFormat:@"%ld",(long)responses.statusCode], [dict objectForKey:@"description"]);
    }else
    {
        failure(error,[NSString stringWithFormat:@"%ld",(long)responses.statusCode], @"网络请求超时");
    }
    
}





/**
 所有的请求都会经过这个方法
 
 @param method 请求方式 枚举值：request_method
 @param url 的url  不需要拼接服务器的url
 @param parma 请求参数 最好是一个字典
 @param isJason 请求数据的格式是否是Jason
 @param showError 当请求服务器出错时是否闪现提示信息
 @param showHud 是否显示正在加载的界面
 @param tableView 当前正在刷新的tableView 传入后可在请求结束时自动停止刷新
 @param success 数据请求成功之后会回调的方法 返回成功的数据
 @param failure 失败后回调的方法
 */
+ (void)requestDataWithMethod:(HttpRequestMethodType)method url:(NSString *)url parma:(id)parma isJason:(BOOL)isJason showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud refreshTableView:(UITableView *)tableView success:(void (^)(id responseObj))success failure:(void (^)(NSError *error,NSString *errorCode,NSString *remark))failure
{
    // 1.没网不清求
    if (![RMTDataServiceTool checkNetworkingRefreshTableView:tableView failure:failure]) {
        return;
    }
   
    // 2.获取请求的全路径 ，并处理请求前UI
    NSString *allURL = [RMTDataServiceTool getAllUrlString:url showHUD:showHud parma:parma];
    
    
    
    // 3.判断请求方式，发起网络请求
    switch (method) {
        case HttpRequestMethodType_POST/*POST请求*/:
        {
            [RMTBaseHttpTool postDataWithURL:allURL parma:parma isJason:isJason showErrorMessage:showError showHUD:showHud refreshTableView:tableView success:^(id responseObj) {
                
                // 成功
                [RMTDataServiceTool requestSuccessWithData:responseObj Success:success refreshTableView:tableView isShowHUD:showHud];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                //失败
                [RMTDataServiceTool requestFaileWithErrorTask:task error:error failure:failure showError:showError refreshTableView:tableView showHUD:showHud];
            }];
        
        }
            break;
        case HttpRequestMethodType_GET/*GET请求*/:
        {
            [RMTBaseHttpTool getDataWithURL:allURL parma:parma isJason:isJason showErrorMessage:showError showHUD:showHud refreshTableView:tableView success:^(id responseObj) {
                
                // 成功
                [RMTDataServiceTool requestSuccessWithData:responseObj Success:success refreshTableView:tableView isShowHUD:showHud];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                //失败
                [RMTDataServiceTool requestFaileWithErrorTask:task error:error failure:failure showError:showError refreshTableView:tableView showHUD:showHud];
            }];
        }
            break;
        case HttpRequestMethodType_DELECT/*DELECT请求*/:
        {
            [RMTBaseHttpTool delectDataWithURL:allURL parma:parma isJason:isJason showErrorMessage:showError showHUD:showHud refreshTableView:tableView success:^(id responseObj) {
                // 成功
                [RMTDataServiceTool requestSuccessWithData:responseObj Success:success refreshTableView:tableView isShowHUD:showHud ];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                //失败
                [RMTDataServiceTool requestFaileWithErrorTask:task error:error failure:failure showError:showError refreshTableView:tableView showHUD:showHud];
            }];
        }
            break;
        case HttpRequestMethodType_PUT/*PUT请求*/:
        {
            [RMTBaseHttpTool putDataWithURL:allURL parma:parma isJason:isJason showErrorMessage:showError showHUD:showHud refreshTableView:tableView success:^(id responseObj) {
                
                // 成功
                [RMTDataServiceTool requestSuccessWithData:responseObj Success:success refreshTableView:tableView isShowHUD:showHud];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                //失败
                [RMTDataServiceTool requestFaileWithErrorTask:task error:error failure:failure showError:showError refreshTableView:tableView showHUD:showHud];
            }];
        }
            break;
            
        default:
            break;
    }
    
  
}



/**
 隐藏HUD和停止刷新

 @param tableView 需要停止刷新的TableView
 @param isShowHUD 原来是否显示了HUD 不显示不隐藏
 */
+ (void)hiddenHUDAndNetworkActivityIndicatorVisible:(UITableView *)tableView isShowHUD:(BOOL)isShowHUD
{
    
  
    //隐藏界面的菊花
    if (isShowHUD) {
        [RMTMessageTool hideLoadingHUD];
    }
    
    // 隐藏状态栏上面的菊花
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //请求成功允许用户操作
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled =YES;
    
    //没有需要停止刷新的tableView
    if (!tableView){return;}
    
    
    //停止刷新
    if ([tableView.mj_footer isRefreshing]) {
        [tableView.mj_footer endRefreshing];
    }
    if ([tableView.mj_header isRefreshing]) {
        [tableView.mj_header endRefreshing];
    }
    
   
    
}



/**
 检查网络状态并做友好提示

 @param tableView 需要停止刷新的tableView
 @param failure 失败的回调
 @return 返回当前网络状态
 */
+ (BOOL)checkNetworkingRefreshTableView:(UITableView *)tableView failure:(void (^)(NSError *error,NSString *errorCode,NSString *remark))failure
{
    // 1 .没有网络就不去请求数据 做一个友好的提示
    if (![RMTMessageTool isHaveNetWork]) {
        
        if (failure) {
            failure(nil,@"-10086",@"世界上最遥远的距离就是没有网络~");
        }
        [RMTMessageTool showMessage:@"世界上最遥远的距离就是没有网络~"];
        [RMTDataServiceTool hiddenHUDAndNetworkActivityIndicatorVisible:tableView isShowHUD:YES];

    }
    return [RMTMessageTool isHaveNetWork];
}


/**
 获取URL全路径，处理开始请求前的UI界面

 @param url 半路径url
 @param showHud 是否显示HUD
 @param parma 请求参数
 @return 返回全路径
 */
+ (NSString *)getAllUrlString:(NSString *)url showHUD:(BOOL)showHud parma:(id)parma
{

    // 2 .处理UI界面
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled =NO;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if (showHud) {
            [RMTMessageTool showLoadingHUD];
        }
    });
    
    // 3.拼接网络请求
    NSString *allURL = [NSString stringWithFormat:@"%@%@",MainURL,url];
    RMTDebugLog(@"当前请求的地址%@，\n参数%@",allURL,parma?parma:@"(无)");
    return allURL;
}



@end
