//
//  AppDelegate+RongCloudSDK.m
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "AppDelegate+RongCloudSDK.h"

@implementation AppDelegate (RongCloudSDK)

- (void)registerRongCloudSDK
{
    [[RCIM sharedRCIM] initWithAppKey:@"8luwapkv85e5l"];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
}
/**
 融云的回调
 
 @param userId 需要获取用户的信息的useriD
 @param completion 获取完成的时候需要的回调
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    RCUserInfo *info =[[RCUserInfo alloc] initWithUserId:userId name:@"讨论组" portrait:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/pic/item/a1ec08fa513d2697a41211245cfbb2fb4216d882.jpg"];
 
    completion(info);
    
    
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion
{
    RCGroup *group = [[RCGroup alloc] initWithGroupId:groupId groupName:@"讨论组" portraitUri:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/pic/item/a1ec08fa513d2697a41211245cfbb2fb4216d882.jpg"];
    completion(group);
    
}
@end
