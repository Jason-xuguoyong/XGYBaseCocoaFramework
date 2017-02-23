//
//  UIWindow+Extension.h
//  RMTiOSApp
//
//  Created by Jason on 2016/11/18.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Extension)
- (UIImage *)screenshot;
- (UIImage *)screenshotWithRect:(CGRect)rect;
@end
