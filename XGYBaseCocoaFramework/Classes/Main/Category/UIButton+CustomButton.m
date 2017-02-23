//
//  UIButton+CustomButton.m
//  XGYiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIButton+CustomButton.h"

@implementation UIButton (CustomButton)
/**
 *  快速创建一个正常状态下的按钮
 *
 *  @param buttonTitle     按钮的标题
 *  @param titleFont       按钮标题的字体
 *  @param titleColor      按钮标题的字体颜色
 *  @param image           按钮的图片
 *  @param backgroundImage 按钮的背景图片
 *  @param target          点击事件对象
 *  @param action          点击事件
 *  @param backgroundColor 按钮的背景颜色
 *
 *  @return 返回创建好的按钮
 */
+(UIButton *)creatCustomButtonNormalStateWithTitile:(NSString *)buttonTitle titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor butttonImage:(UIImage *)image backgroundImage:(UIImage *)backgroundImage backgroundColor:(UIColor *)backgroundColor clickThingTarget:(id)target action:(SEL)action
{
    //创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮的标题
    if (buttonTitle) {[button setTitle:buttonTitle forState:UIControlStateNormal];}
    //设置按钮的字体
    if (titleFont) {button.titleLabel.font = titleFont;}
    //设置按钮的字体颜色
    if (titleColor) { [button setTitleColor:titleColor forState:UIControlStateNormal];}
    //设置按钮的图标
    if (image) {[button setImage:image forState:UIControlStateNormal];}
    //设置按钮的背景图标
    if (backgroundImage) {[button setBackgroundImage:backgroundImage forState:UIControlStateNormal];}
    //设置按钮背景颜色
    if (backgroundColor) {[button setBackgroundColor:backgroundColor];}
    //设置按钮的点击事件
    if (target && action) {[button addButtonTouchUpInsideTarget:target action:action];}
    return button;
    
}

/**
 *  设置选中状态下的button的属性
 *
 *  @param buttonTitle
 按钮的标题
 */
+ (UIButton *)createMainButtonWithTitle:(NSString *)buttonTitle clickThingTarget:(id)target action:(SEL)action
{
    
    UIButton *btn = [UIButton creatCustomButtonNormalStateWithTitile:buttonTitle titleFont:textFontWithArtFont(30) titleColor:[UIColor whiteColor] butttonImage:nil backgroundImage:nil backgroundColor:MainColor clickThingTarget:target action:action];
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = YES;
    return btn;
}



/**
 *  给按钮增加一个点击事件
 *
 *  @param target 时间的对象
 *  @param action 事件
 */
- (void)addButtonTouchUpInsideTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  设置按钮图片和文字的对齐方式
 */
- (void)setButtonImageAndTitleAlignmentCenter
{
    // 设置button的图片的约束
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.sd_layout
    .topSpaceToView(self, 5)
    .centerXEqualToView(self)
    .heightRatioToView(self, 0.5)
    .widthEqualToHeight();
    
    // 设置button的label的约束
    self.titleLabel.sd_layout
    .topSpaceToView(self.imageView, 5)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self, 5);
    [self updateLayout];
}



/**
 *  快速创建一个简单的常用按钮
 *
 *  @param buttonTitle
 按钮的标题
 */
+ (UIButton *)createNormalButton:(NSString *)buttonTitle clickThingTarget:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton creatCustomButtonNormalStateWithTitile:buttonTitle titleFont:textFontWithArtFont(30) titleColor:textColor222222 butttonImage:nil backgroundImage:nil backgroundColor:nil clickThingTarget:target action:action];
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = UIColorFromRGB(0xd7d7d7).CGColor;
    btn.layer.cornerRadius = 5.0f;
   
    btn.height = 44;
        return btn;
    
}
@end
