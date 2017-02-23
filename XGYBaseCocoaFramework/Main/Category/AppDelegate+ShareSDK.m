//
//  AppDelegate+ShareSDK.m
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "AppDelegate+ShareSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@implementation AppDelegate (ShareSDK)
/**
 初始化分享
 */
-(void)initShareSdk
{
#pragma mark ===Share社会化分享======
    //
    [ShareSDK registerApp:shareSDKKey activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeQQFriend)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType) {
                case SSDKPlatformTypeWechat:
            {
                [ShareSDKConnector connectWeChat:[WXApi class]];
            }
                break;
                case SSDKPlatformTypeQQ:
            {
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
            }
                break;
                case SSDKPlatformTypeSinaWeibo:
            {
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
            }
                break;
                
            default:
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
                case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:weiboAppKey
                                          appSecret:weiboAppSecret
                                        redirectUri:weiboRedireURL
                                           authType:SSDKAuthTypeBoth];
                break;
                
                
                case SSDKPlatformTypeWechat:
                //设置微信应用信息
                [appInfo SSDKSetupWeChatByAppId:weixinAppKey
                                      appSecret:weixinAppSecret];
                
                break;
                case SSDKPlatformTypeQQ:
                //设置QQ应用信息，其中authType设置为只用SSO形式授权
                [appInfo SSDKSetupQQByAppId:QQAppKey
                                     appKey:QQAppSecret
                                   authType:SSDKAuthTypeSSO];
                break;
            default:
                break;
        }
        
    }];
}
@end
