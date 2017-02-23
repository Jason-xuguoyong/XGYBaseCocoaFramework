//
//  XGYMessageTool.h
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/8.
//  Copyright © 2017年 Jason. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface XGYMessageTool : NSObject
/**
 *  快速闪现一个提示文字 提示
 *
 *  @param message 提示文字
 */
+(void)showMessage:(NSString *)message;

/**
 *  闪现一个提示文字
 *
 *  @param message  提示文字
 *  @param showTime 文字显示时间
 */
+ (void)showMessage:(NSString *)message showTime:(CGFloat)showTime;

/**
 *  在View上显示正在加载的动画
 */
+ (void)showLoadingHUD;

/**
 *  在View上显示失败消息
 */

+ (void)showLoadingHUDWithErrorMessage:(NSString *)message;
/**
 *  在View上显示成功消息
 */

+ (void)showLoadingHUDWithSuccessMessage:(NSString *)message;
/**
 *  隐藏View上正在加载的动画
 */

+ (void)hideLoadingHUD;
/**
 *  判断当前是否有网络
 */
+ (BOOL)isHaveNetWork;

@end
