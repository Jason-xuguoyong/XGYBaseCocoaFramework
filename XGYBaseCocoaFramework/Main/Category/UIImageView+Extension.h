//
//  UIImageView+Extension.h
//  RMTiOSApp
//
//  Created by Jason on 2016/12/1.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/**
 设置图片 自带网络缓存

 @param imageUrlString 图片的地址 不需要拼接前缀
 @param replaceImageName 占位图
 */
- (void)setImageWithImageUrlString:(NSString *)imageUrlString replaceImageName:(NSString *)replaceImageName;
@end
