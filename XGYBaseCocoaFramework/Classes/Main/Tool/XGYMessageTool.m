//
//  XGYMessageTool.m
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/8.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "XGYMessageTool.h"
#import "SVProgressHUD.h"
#import <MBProgressHUD+BWMExtension.h>

@implementation XGYMessageTool
+ (void)initialize
{
    [SVProgressHUD setBackgroundLayerColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.3]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setInfoImage:nil];
    
}
/**
 *  快速闪现一个提示文字 提示（字数最好不要超过20个字）
 *
 *  @param message 提示文字 默认消失时间为1s
 */
+(void)showMessage:(NSString *)message
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showMessage:message showTime:1.5f];
    });
   
}
/**
 *  闪现一个提示文字
 *
 *  @param message  提示文字
 *  @param showTime 文字显示时间
 */
+ (void)showMessage:(NSString *)message showTime:(CGFloat)showTime
{
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.margin = 10.f;
    hud.yOffset = -50;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:showTime];
    
}

/**
 *  在View上显示正在加载的动画
 */
+ (void)showLoadingHUD
{
    [SVProgressHUD setCornerRadius:15.0f];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD show];
}

/**
 *  在View上显示正在加载的动画
 */
+ (void)showLoadingHUDWithErrorMessage:(NSString *)message
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0f];
    [SVProgressHUD showErrorWithStatus:message];
}

/**
 *  在View上显示正在加载的动画
 */
+ (void)showLoadingHUDWithSuccessMessage:(NSString *)message
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0f];
    [SVProgressHUD showSuccessWithStatus:message];
    
}



/**
 *  隐藏View上正在加载的动画
 */
+ (void)hideLoadingHUD
{
    [SVProgressHUD dismiss];
}

/**
 *  判断当前是否有网络
 */
+ (BOOL)isHaveNetWork
{
    NSString *networkState = [[NSUserDefaults standardUserDefaults] objectForKey:@"networkState"];
    if (![networkState isEqualToString:@"haveNetwork"]) {
        return NO;
    }
    return YES;
}
@end
