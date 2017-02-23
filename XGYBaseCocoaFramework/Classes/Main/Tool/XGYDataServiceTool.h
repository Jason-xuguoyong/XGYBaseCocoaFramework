//
//  XGYDataServiceTool.h
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,HttpRequestMethodType)
{
    HttpRequestMethodType_POST=10,
    HttpRequestMethodType_GET,
    HttpRequestMethodType_DELECT,
    HttpRequestMethodType_PUT

};



@interface XGYDataServiceTool : NSObject


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
+ (void)requestDataWithMethod:(HttpRequestMethodType)method url:(NSString *)url parma:(id)parma isJason:(BOOL)isJason showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud refreshTableView:(UITableView *)tableView success:(void (^)(id responseObj))success failure:(void (^)(NSError *error,NSString *errorCode,NSString *remark))failure;

@end
