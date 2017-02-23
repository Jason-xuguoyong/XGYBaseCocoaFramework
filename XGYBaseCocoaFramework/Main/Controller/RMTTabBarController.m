//
//  RMTTabBarController.m
//  RMTiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//  

#import "RMTTabBarController.h"
#import "RMTBaseNavViewController.h"
#import "RMTTabar.h"

#import "TempHomeViewController.h"
#import "TempSecondViewController.h"
#import "TempTestViewController.h"
#import "TempThreeViewController.h"


@interface RMTTabBarController ()

@end

@implementation RMTTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加所有的子控制器
    [self addAllChildVcs];
    
    // 创建自定义tabbar
    [self addCustomTabBar];

   
}


- (void)changeSelectIndex:(NSNotification *)not
{
    int index = [[not.userInfo objectForKey:@"index"] intValue];
    [self setSelectedIndex:index];
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    
    // 创建自定义tabbar
    RMTTabar *customTabBar = [[RMTTabar alloc] init];
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];

}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    
    [self addOneChlildVc:[[TempHomeViewController alloc] init] title:@"首页" imageName:@"global_tabbar_icon_normal" selectedImageName:@"global_tabbar_icon_select"];
    
    [self addOneChlildVc:[[TempSecondViewController alloc] init] title:@"消息" imageName:@"message_tabbar_icon_normal" selectedImageName:@"message_tabbar_icon_select"];
    
  
    [self addOneChlildVc:[[TempTestViewController alloc] init] title:@"商家" imageName:@"store_tabbar_icon_normal" selectedImageName:@"store_tabbar_icon_select"];
    
    [self addOneChlildVc:[[TempThreeViewController alloc] init] title:@"我的" imageName:@"userCenter_tabbar_icon_normal" selectedImageName:@"userCenter_tabbar_icon_select"];
}
/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x666666);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem  setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0xF01E1E);
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
   RMTBaseNavViewController *nav = [[RMTBaseNavViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}



@end
