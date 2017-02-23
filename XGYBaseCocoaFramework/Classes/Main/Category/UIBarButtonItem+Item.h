//
//  UIBarButtonItem+Item.h
//  XGYiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;


+(UIBarButtonItem *)itemWithTitle:(NSString *)title textColor:(UIColor *)textColor target:(id)target action:(SEL)action;

@end
