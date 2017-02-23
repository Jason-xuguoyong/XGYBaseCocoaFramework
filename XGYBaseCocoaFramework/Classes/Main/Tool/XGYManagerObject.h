//
//  XGYManagerObject.h
//  XGYiOSApp
//
//  Created by Jason on 2016/12/2.
//  Copyright © 2016年 Jason. All rights reserved.
//  单例对象

#import <UIKit/UIKit.h>


@interface XGYManagerObject : NSObject

/**
 获取根控制器的类名

 @return 根控制器类名字符串
 */
+ (NSArray*)rootController;

@end
