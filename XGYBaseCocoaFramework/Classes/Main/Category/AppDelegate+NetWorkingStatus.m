//
//  AppDelegate+NetWorkingStatus.m
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "AppDelegate+NetWorkingStatus.h"
#import "AFNetworkReachabilityManager.h"

@implementation AppDelegate (NetWorkingStatus)
//开启器网络监听
- (void)openNetWorkingMonitor
{
    
    //让SDWebImage全局支持https
     [[SDWebImageManager sharedManager].imageDownloader setValue: nil forHTTPHeaderField:@"Accept"];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"haveNetwork" forKey:@"networkState"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //延时监听
    [self performSelector:@selector(netWorkingStateS) withObject:nil afterDelay:3.0f];
    
}

- (void)netWorkingStateS
{

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //网络发生改变
        BOOL result = YES;
        if (![XGYMessageTool isHaveNetWork]) {
            //原来没有网络现在有了
            result = NO;
        }
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                XGYDebugLog(@"未识别的网络");
                [[NSUserDefaults standardUserDefaults] setObject:@"haveNetwork" forKey:@"networkState"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                XGYDebugLog(@"不可达的网络(未连接)");
                [[NSUserDefaults standardUserDefaults] setObject:@"noNetwork" forKey:@"networkState"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                XGYDebugLog(@"2G,3G,4G...的网络");
                [[NSUserDefaults standardUserDefaults] setObject:@"haveNetwork" forKey:@"networkState"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                XGYDebugLog(@"wifi的网络");
                [[NSUserDefaults standardUserDefaults] setObject:@"haveNetwork" forKey:@"networkState"];
                break;
            default:
                break;
        }

        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
    [manager startMonitoring];
}

@end
