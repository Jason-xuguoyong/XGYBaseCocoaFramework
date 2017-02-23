//
//  UIImage+Extension.h
//  RMTiOSApp
//
//  Created by Jason on 2016/12/1.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


/**
 根据base64的字符串获取图片
 */
+ (UIImage *)getImageWithBase64String:(NSString *)imageString;



@end
