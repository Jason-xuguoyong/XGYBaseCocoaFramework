//
//  UIFont+Artdesigner.m
//  RMTiOSApp
//
//  Created by Jason on 2016/11/7.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIFont+Artdesigner.h"

@implementation UIFont (Artdesigner)
    
+(UIFont *)artDesignerFontSize:(CGFloat)fontSize{
    //字体是美工字体的一半
    CGFloat systemSize = fontSize/2.0f;
    return [UIFont systemFontOfSize:systemSize];
}
@end
