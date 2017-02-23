//
//  RMTManagerObject.m
//  RMTiOSApp
//
//  Created by Jason on 2016/12/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "RMTManagerObject.h"


@interface RMTManagerObject ()
@end



@implementation RMTManagerObject

/**
 创建单例对象
 
 @return RMTManagerObject
 */
+ (RMTManagerObject *)shareInstance
{
    static RMTManagerObject * managerObject_;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerObject_ = [[RMTManagerObject alloc]init];
    });
    return managerObject_;
}
/**
 获取根控制器的类名
 
 @return 根控制器类名字符串
 */
+ (NSArray*)rootController
{
    return @[@"TempTestViewController",@"TempHomeViewController",@"TempSecondViewController",@"TempThreeViewController"];

}
@end
