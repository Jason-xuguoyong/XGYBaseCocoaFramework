//
//  RMTAppShareView.h
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/21.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTAppShareView : UIView

/**
 初始化方法
 
 @param shareURL 分享的URL地址
 @param title 分享的标题
 @param shareConten 分享的文字内容
 @param shareIcon 分享的图片
 @return 返回创建好的对象
 */
- (instancetype)initWithShareURLString:(NSString *)shareURL shareTitle:(NSString *)title shareConten:(NSString *)shareConten shareIcon:(NSString *)shareIcon;
/**
 显示分享View的方法
 */
- (void)showShareViewWithAnimation:(BOOL)annimation;

@end
