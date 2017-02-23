//
//  XGYControllerTool.h
//  XGYiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EAIntroView.h>
@interface XGYControllerTool : NSObject

/**
 *  选择根控制器
 *  1 直接进入首页
 *  2 进入登录页面
 *  3 显示新特性（版本更新或者是第一次版本的介绍）
 */
+ (void)chooseRootViewController;


/**
 分享方法
 @param shareURL 分享的地址
 @param title 分享的标题
 @param shareConten 分享的URL
 */
+ (void)showShareViewWithShareURLString:(NSString *)shareURL shareTitle:(NSString *)title shareConten:(NSString *)shareConten shareIcon:(NSString *)icon;


/**
 显示alerView的方法 该方法只支持左右两个按钮
 
 @param title 标题
 @param message 描述文字
 @param leftButtonTitle 左边按钮的标题
 @param rightButtonTitle 右边按钮的标题
 @param leftButtonClickBlock 左边按钮的点击的回调
 @param rightButtonClickBlock 右边按钮的点击的回调
 */
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle leftButtonClickBlock:(void(^)(NSString *sender))leftButtonClickBlock rightButtonClickBlock:(void(^)(NSString *sender))rightButtonClickBlock;


/**
 显示alerView的方法 该方法只支持单个按钮
 
 @param title  标题
 @param message 描述文字
 @param buttonTitle 按钮的标题
 @param buttonClickBlock 按钮的点击事件
 */
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonClickBlock:(void(^)(NSString *sender))buttonClickBlock;

/**
 显示actionSheet的方法
 
 @param title 标题
 @param cancelButtonTitle 取消按钮的标题
 @param titlesArray 其他按钮的标题 形式 @[@"从相册选择",@"拍照",@"其他",...]
 @param index 需要着重显示的文字在数组titlesArray中的下标 如果不需要请传 10086
 @param cancelButtonClickBlock 取消按钮点击的回调
 @param buttonClickBlock 所有按钮点击的回调 将当前点击的按钮和按钮在titlesArray中的下标返回
 */
+ (void)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle buttonTitleArray:(NSArray *)titlesArray  destructiveButtonIndex:(NSNumber *)index cancelButtonClick:(void(^)(UIButton *clickButton))cancelButtonClickBlock buttonClickBlock:(void(^)(NSString *clickButtonTitle,int buttonIndex))buttonClickBlock;



/**
 *  显示欢迎界面 逻辑已经处理完毕 一下三种情况会显示欢迎界面 （引导页）
 *  1.新用户第一次下载
 *  2.版本更新
 *  3.用户卸载后再次下载
 @param rootView 需要展示的界面
 @param delegate 代理对象
 @return 是否展示
 */
+ (BOOL)showNewFeaturesInView:(UIView *)rootView delegate:(id<EAIntroDelegate>)delegate;




@end



