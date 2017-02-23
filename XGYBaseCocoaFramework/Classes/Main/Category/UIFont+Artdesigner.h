//
//  UIFont+Artdesigner.h
//  XGYiOSApp
//
//  Created by Jason on 2016/11/7.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Artdesigner)

/**
 系统字体和美工字体的转换

 @param fontSize 美工字体大小
 @return 系统字体大小
 */
+ (UIFont *)artDesignerFontSize:(CGFloat)fontSize;
    
@end
