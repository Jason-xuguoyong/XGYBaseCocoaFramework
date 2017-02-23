//
//  XGYManagerObject.m
//  XGYiOSApp
//
//  Created by Jason on 2016/12/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XGYManagerObject.h"


@interface XGYManagerObject ()
@end



@implementation XGYManagerObject

/**
 创建单例对象
 
 @return XGYManagerObject
 */
+ (XGYManagerObject *)shareInstance
{
    static XGYManagerObject * managerObject_;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerObject_ = [[XGYManagerObject alloc]init];
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
