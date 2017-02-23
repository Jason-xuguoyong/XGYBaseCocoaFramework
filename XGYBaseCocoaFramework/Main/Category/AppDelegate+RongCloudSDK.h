//
//  AppDelegate+RongCloudSDK.h
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
@interface AppDelegate (RongCloudSDK) <RCIMUserInfoDataSource,RCIMGroupInfoDataSource>

/**
 初始化SDK
 */
- (void)registerRongCloudSDK;
@end
