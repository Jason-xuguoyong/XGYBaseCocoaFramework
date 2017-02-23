//
//  UIBarButtonItem+Item.m
//  XGYiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)itemWithTitle:(NSString *)title textColor:(UIColor *)textColor target:(id)target action:(SEL)action
{

    UIButton*_rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [_rightButton setTitle:title forState:UIControlStateNormal];
    [_rightButton setTitleColor:textColor forState:UIControlStateNormal];
    [_rightButton.titleLabel setFont:textFontWithArtFont(24)];
    _rightButton.titleLabel.sd_layout.rightSpaceToView(_rightButton,-10).topEqualToView(_rightButton).bottomEqualToView(_rightButton).widthIs(40);
    [_rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   return  [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
}

@end
