//
//  XGYTabar.m
// XGYEvaluationRCode
//
//  Created by Jason on 2017/2/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "XGYTabar.h"

@implementation XGYTabar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //改变tabbar 线条颜色
        [self setTBbarSeperateColor];
    }
    return self;
}
/**
 *  设置tabbar线条的颜色
 */
- (void)setTBbarSeperateColor
{
    
    self.barStyle = UIBarStyleBlack;
    [self setShadowImage:[UIImage new]];
    UIImage *iamge = [UIImage imageNamed:@"tabbar_line_single_tset"];
    self.backgroundImage = iamge;
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
  // 设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
}


/**
 *  设置所有tabbarButton的frame
 */
- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    // 计算button的尺寸
    CGFloat buttonW = self.width / self.items.count;
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    tabBarButton.x = buttonW * index;
    
    tabBarButton.y = 0;
}
@end
