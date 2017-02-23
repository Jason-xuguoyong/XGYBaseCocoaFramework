//
//  RMTBaseViewController.h
//  RMTiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//  工程的基类控制器

#import <UIKit/UIKit.h>

@interface RMTBaseViewController : UIViewController
@property (nonatomic,strong) UITableView *tableView;


/**
 *  是否需要添加tableView
 *
 *  @param delegate tableView的代理
 *
 *  @return 返回一个tableView
 */
- (UITableView *)addTableViewWithDelegate:(id <UITableViewDelegate,UITableViewDataSource>)delegate style:(UITableViewStyle)style;

/**
 给界面添加一个TableView

 @param superView 需要添加到的View
 @param frame tableView的frame
 @param delegate 代理对象
 @param style  tableView的样式
 @return UITableView
 */
- (UITableView *)addTableViewForView:(UIView *)superView frame:(CGRect)frame Delegate:(id <UITableViewDelegate,UITableViewDataSource>)delegate style:(UITableViewStyle)style;

@end
