//
//  XGYControllerTool.m
//  XGYiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XGYControllerTool.h"
#import "XGYTabBarController.h"
#import "XGYAppShareView.h"
#import "XGYAlertView.h"
#import "XGYActionSheet.h"
#import <EAIntroPage.h>
#import "XGYBaseNavViewController.h"
#import "AppDelegate.h"
@interface XGYControllerTool ()
@end


@implementation XGYControllerTool

/**
 分享方法
 @param shareURL 分享的地址
 @param title 分享的标题
 @param shareConten 分享的URL
 */
+ (void)showShareViewWithShareURLString:(NSString *)shareURL shareTitle:(NSString *)title shareConten:(NSString *)shareConten shareIcon:(NSString *)icon
{
    XGYAppShareView *share = [[XGYAppShareView alloc] initWithShareURLString:shareURL shareTitle:title shareConten:shareConten shareIcon:icon];
    [share showShareViewWithAnimation:YES];


}



/**
 显示alerView的方法 该方法只支持左右两个按钮
 
 @param title 标题
 @param message 描述文字
 @param leftButtonTitle 左边按钮的标题
 @param rightButtonTitle 右边按钮的标题
 @param leftButtonClickBlock 左边按钮的点击的回调
 @param rightButtonClickBlock 右边按钮的点击的回调
 */
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle leftButtonClickBlock:(void(^)(NSString *sender))leftButtonClickBlock rightButtonClickBlock:(void(^)(NSString *sender))rightButtonClickBlock
{
    
    XGYAlertView *alertView =[[XGYAlertView alloc] initWithTitle:title message:message leftActionTitle:leftButtonTitle rightActionTitle:rightButtonTitle animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
        if (actionType == AlertViewActionTypeLeft) {
            if (leftButtonClickBlock) {
                leftButtonClickBlock(leftButtonTitle);
            }
            
        }else
        {
            if (rightButtonClickBlock) {
                rightButtonClickBlock(rightButtonTitle);
            }
        }
    }];
    alertView.blurCurrentBackgroundView = NO;
    [alertView show];
}


/**
 显示alerView的方法 该方法只支持单个按钮
 
 @param title  标题
 @param message 描述文字
 @param buttonTitle 按钮的标题
 @param buttonClickBlock 按钮的点击事件
 */
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonClickBlock:(void(^)(NSString *sender))buttonClickBlock
{

    XGYAlertView *alertView =[[XGYAlertView alloc] initWithTitle:title message:message leftActionTitle:buttonTitle rightActionTitle:nil animationStyle:AlertViewAnimationZoom selectAction:^(AlertViewActionType actionType) {
        if (buttonClickBlock) {
            buttonClickBlock(title);
        }
    }];
 
    alertView.blurCurrentBackgroundView = NO;
    [alertView show];

}


/**
 显示actionSheet的方法
 
 @param title 标题
 @param cancelButtonTitle 取消按钮的标题
 @param titlesArray 其他按钮的标题 形式 @[@"从相册选择",@"拍照",@"其他",...]
 @param index 需要着重显示的文字在数组titlesArray中的下标 如果不需要请传 10086
 @param cancelButtonClickBlock 取消按钮点击的回调
 @param buttonClickBlock 所有按钮点击的回调 将当前点击的按钮和按钮在titlesArray中的下标返回
 */
+ (void)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle buttonTitleArray:(NSArray *)titlesArray  destructiveButtonIndex:(NSNumber *)index cancelButtonClick:(void(^)(UIButton *clickButton))cancelButtonClickBlock buttonClickBlock:(void(^)(NSString *clickButtonTitle,int buttonIndex))buttonClickBlock
{
    XGYActionSheet *sheet =  [[XGYActionSheet alloc] initActionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle buttonTitleArray:titlesArray destructiveButtonIndex:index cancelButtonClick:cancelButtonClickBlock buttonClickBlock:buttonClickBlock];
    [sheet showMenueViewWithAnimation:NO];
}


/**
 *  选择根控制器
 *  1 直接进入首页
 *  2 进入登录页面
 *  3 显示新特性（版本更新或者是第一次版本的介绍）
 */
+ (void)chooseRootViewController
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    UIWindow *window = app.window;
   
    window.rootViewController = [[XGYTabBarController alloc] init];
       
   
}
/**
 *  显示欢迎界面 逻辑已经处理完毕 一下三种情况会显示欢迎界面 （引导页）
 *  1.新用户第一次下载
 *  2.版本更新
 *  3.用户卸载后再次下载
 @param rootView 需要展示的界面
 @param delegate 代理对象
 */
+ (BOOL)showNewFeaturesInView:(UIView *)rootView delegate:(id<EAIntroDelegate>)delegate
{
   

     // 如何知道第一次使用这个版本？比较上次的使用情况
    
     NSString *versionKey = currentVersionKey;

     // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     NSString *lastVersion = [defaults objectForKey:versionKey];
     
     // 获得当前打开软件的版本号
     NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
     if ([currentVersion isEqualToString:lastVersion]) {
     // 当前版本号 == 上次使用的版本：
         return NO;
     }
    
    
    //  当前版本号 != 上次使用的版本 ==> 存储这次使用的软件版本
    [defaults setObject:currentVersion forKey:versionKey];
    [defaults synchronize];
  
    NSString *name = @"";
    if (isiPhone4) {
      name = @"_iPhone4";
    }
    
    //展示欢迎界面
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"Intro_page_one",name]];

    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"Intro_page_two",name]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"Intro_page_three",name]];
   
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3]];
    [intro.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [intro setDelegate:delegate];
    intro.scrollingEnabled =  YES;
    intro.tapToNext = YES;
    [intro showInView:rootView animateDuration:0.3];
    return YES;
}












































#pragma mark =====该工具使用示例
/** ActionSheet***/

 /***
 [XGYControllerTool showActionSheetWithTitle:@"请选择图片来源" cancelButtonTitle:@"取消" buttonTitleArray:@[@"拍摄",@"从相册选择"] destructiveButtonIndex:0 cancelButtonClick:^(UIButton *clickButton) {
 XGYDebugLog(@"点击取消按钮");
 } buttonClickBlock:^(NSString *clickButtonTitle, int buttonIndex) {
 XGYDebugLog(@"当前点击的标题是%@，所在数组下表是%d",clickButtonTitle,buttonIndex);
 }];
 
 
 **/


/** AlertView***/

/***
 [XGYControllerTool showAlertViewWithTitle:@"是否确认退出登录?" message:@"退出登陆" leftButtonTitle:@"确定" rightButtonTitle:@"取消" leftButtonClickBlock:^(UIButton *sender) {
 XGYDebugLog(@"右边按钮的点击事件");
 } rightButtonClickBlock:^(UIButton *sender) {
 XGYDebugLog(@"左边按钮的点击事件");
 }];
 
 
 **/

/** shareAppView***/

/***
    [XGYControllerTool showShareViewWithShareURLString:@"http://www.baidu.com"];

 **/





@end
