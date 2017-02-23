//
//  MacroDefinitionForTool.h
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/8.
//  Copyright © 2017年 Jason. All rights reserved.
//

#ifndef MacroDefinitionForTool_h
#define MacroDefinitionForTool_h

/**
 * 屏宽-高
 */
#define d_screen_width [UIScreen mainScreen].bounds.size.width
#define d_screen_height [UIScreen mainScreen].bounds.size.height


/**
 * 判断当前是iPhone几
 */
#define isiPhone4 [UIScreen mainScreen].bounds.size.height==480
#define isiPhone5 [UIScreen mainScreen].bounds.size.height==568
#define isiPhone6 [UIScreen mainScreen].bounds.size.height==667
#define isiPhone7 [UIScreen mainScreen].bounds.size.height==667
#define isiPhone6p [UIScreen mainScreen].bounds.size.height==736
#define isiPhone7p [UIScreen mainScreen].bounds.size.height==736
//快速判断+
#define isiPhone6Or7 isiPhone6||isiPhone7
#define isiPhone6POr7P isiPhone6p||isiPhone7p


/**
 * 判断当前的版本
 */

//当前的版本是否等于v
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

//当前的版本是否高于v
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

//当前的版本是否高于或等于v
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//当前的版本是否低于v
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

//当前的版本是否低于或等于v
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//获取当前版本号的key
#define currentVersionKey @"CFBundleShortVersionString"

// 颜色
#define RMTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

// 随机色
#define RMTRandomColor RMTColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//颜色RGB 16进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



//判断是否是字典类
#define isDictionaryClass(dic)  [dic isKindOfClass:[NSDictionary class]]
//判断是否是字符串类
#define isStringClass(string)  [string isKindOfClass:[NSString class]]
//判断是否是数组类
#define isArrayClass(array) [array isKindOfClass:[NSArray class]]

//图片转二进制
#define dataFromImage(image)  UIImageJPEGRepresentation(image, 0.7)




#endif /* MacroDefinitionForTool_h */
