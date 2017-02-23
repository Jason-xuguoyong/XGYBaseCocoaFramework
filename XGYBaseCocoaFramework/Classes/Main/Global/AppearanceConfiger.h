//
//  AppearanceConfiger.h
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/8.
//  Copyright © 2017年 Jason. All rights reserved.
//

#ifndef AppearanceConfiger_h
#define AppearanceConfiger_h


// 导航栏标题的字体
#define XGYNavigationTitleFont textFontWithArtFont(36)

//界面的背景颜色
#define viewAndTableViewBackgroundColor UIColorFromRGB(0xF8F8F8)
//分割线颜色
#define tableViewSeparateColor UIColorFromRGB(0xD7D7D7)
//主色调
#define MainColor  UIColorFromRGB(0xF01E1E)

//主色调
#define MainOriginColor  UIColorFromRGB(0xffad2b)


//UI颜色控制
#define kUIToneBackgroundColor UIColorFromRGB(0x00bd8c) //UI整体背景色调 与文字颜色一一对应
#define kUIToneTextColor UIColorFromRGB(0xffffff) //UI整体文字色调 与背景颜色对应
#define kStatusBarStyle UIStatusBarStyleLightContent //状态栏样式
#define kViewBackgroundColor UIColorFromRGB(0xf5f5f5) //界面View背景颜色


//字体之间的转换
#define textFontWithArtFont(fontsize) [UIFont artDesignerFontSize:fontsize]

#define textColor666666 UIColorFromRGB(0x666666)
#define textColor868686 UIColorFromRGB(0x868686)
#define textColor999999 UIColorFromRGB(0x999999)
#define textColor222222 UIColorFromRGB(0x222222)

//tableView右边的发现按钮的大小 >

#define tableViewDisCoverImageWith 15
#define tableViewDisCoverImageHeight 15

#define defaultHeadImageName @"default_head_icon"
#define defaultPicImageName @"default_pic_imageName"


#endif /* AppearanceConfiger_h */
