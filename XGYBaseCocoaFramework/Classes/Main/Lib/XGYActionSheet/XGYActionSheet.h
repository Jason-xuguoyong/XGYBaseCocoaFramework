//
//  XGYActionSheet.h
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/21.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGYActionSheet : UIView

/**
 初始化方法
 
 @param title 标题
 @param cancelButtonTitle 取消按钮的标题
 @param titlesArray 其他按钮的标题 形式 @[@"从相册选择",@"拍照",@"其他",...]
 @param index 需要着重显示的文字在数组titlesArray中的下标 如果不需要请传 10086
 @param cancelButtonClickBlock 取消按钮点击的回调
 @param buttonClickBlock 所有按钮点击的回调 将当前点击的按钮和按钮在titlesArray中的下标返回
 */
- (instancetype)initActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle buttonTitleArray:(NSArray *)titlesArray  destructiveButtonIndex:(NSNumber *)index cancelButtonClick:(void(^)(UIButton *clickButton))cancelButtonClickBlock buttonClickBlock:(void(^)(NSString *clickButtonTitle,int buttonIndex))buttonClickBlock;

/**
 显示ActionSheet的方法
 */
- (void)showMenueViewWithAnimation:(BOOL)annimation;
@end
