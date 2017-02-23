//
//  AppDelegate+UMConfigMobClick.m
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "AppDelegate+UMConfigMobClick.h"

#import <UMMobClick/MobClick.h>

@implementation AppDelegate (UMConfigMobClick)
/**
 初始化友盟SDK
 */
-(void) initUmengSDK
{
    UMConfigInstance.appKey = UmengAppkey;
    UMConfigInstance.channelId = @"App Store";
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];
}
@end
