//
//  UIImage+Extension.m
//  RMTiOSApp
//
//  Created by Jason on 2016/12/1.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)getImageWithBase64String:(NSString *)imageString
{
    if (!imageString) {
        return nil;
    }
    NSData *_decodedImageData= [[NSData alloc] initWithBase64Encoding:imageString];
    return  [UIImage imageWithData:_decodedImageData];
}
@end
