//
//  XGYMenueView.h
//  RMTiOSApp
//
//  Created by Jason on 2016/11/4.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGYMenueView : UIView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *menueTableView;

@property (nonatomic,strong) void (^didClickButtonBlock)(NSString *title,int index);


/**
  实例化菜单栏

 @param title 标题
 @param buttonTitleArray 所有按钮的标题
 @param frame 坐标
 @param index 需要显示红色的按钮所在的位置
 */
- (instancetype)initWithMessageTitle:(NSString *)title buttonTitleArray:(NSArray *)buttonTitleArray Frame:(CGRect)frame destructiveButtonIndex:(NSNumber *)index;


@end
