//
//  AppDelegate.m
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/8.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "AppDelegate.h"
#import "TempTestViewController.h"
#import "AppDelegate+ShareSDK.h"
#import "AppDelegate+NetWorkingStatus.h"
#import "AppDelegate+UMConfigMobClick.h"
#import <ZMCreditSDK/ALCreditService.h>
#import "AppDelegate+RongCloudSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //1. 分享
    [self initShareSdk];
    //2. 开启网络监听
    [self openNetWorkingMonitor];
    //3. 初始化友盟SDK
    [self initUmengSDK];
    //4.注册芝麻信用
    [[ALCreditService sharedService] resgisterApp];
    //注册融云
    [self registerRongCloudSDK];
    
    //选择根控制器
    [RMTControllerTool chooseRootViewController];
    
   
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
