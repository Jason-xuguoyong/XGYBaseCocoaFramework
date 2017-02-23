//
//  UILabel+CreateLabel.m
//  RMTiOSApp
//
//  Created by Jason on 2016/11/11.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UILabel+CreateLabel.h"

@implementation UILabel (CreateLabel)


/**
 创建一个label

 @param title 标题
 @param tColor 字体颜色
 @param font 字体大小
 @param textAlignment 文字的对齐方式
 @return labl
 */
+ (UILabel *)createLabelWithTitle:(NSString *)title titleColor:(UIColor *)tColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    if (title) {
        label.text = title;
    }
    if (tColor) {
        label.textColor = tColor;
    }
    if (font) {
        label.font = font;
    }
    label.textAlignment = textAlignment;
    return label;
    


}

@end
