//
//  RMTBaseViewController.m
//  RMTiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "RMTBaseViewController.h"
#import <UMMobClick/MobClick.h>

@interface RMTBaseViewController ()
@end

@implementation RMTBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewAndTableViewBackgroundColor;
    NSString *className = NSStringFromClass([self class]);
    if (![[RMTManagerObject rootController] containsObject:className]) {
        // 设置导航栏按钮
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"view_leftAndBack_white_icon_origin_back" highImageName:@"view_leftAndBack_white_icon_origin_back" target:self action:@selector(backAction:)];
    }
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

#pragma mark - Action
- (void)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ==如果需要添加tableView 直接调用一下方法即可
/**
 *  是否需要添加tableView
 *
 *  @param delegate tableView的代理
 *
 *  @return 返回一个tableView
 */
- (UITableView *)addTableViewWithDelegate:(id <UITableViewDelegate,UITableViewDataSource>)delegate style:(UITableViewStyle)style
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    [self.view addSubview:tableView];
    tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [tableView updateLayout];
    
    
    tableView.backgroundColor = viewAndTableViewBackgroundColor;
    tableView.separatorColor = tableViewSeparateColor;
    return tableView;
}

/**
 给界面添加一个TableView
 
 @param superView 需要添加到的View
 @param frame tableView的frame
 @param delegate 代理对象
 @param style  tableView的样式
 @return UITableView
 */
- (UITableView *)addTableViewForView:(UIView *)superView frame:(CGRect)frame Delegate:(id <UITableViewDelegate,UITableViewDataSource>)delegate style:(UITableViewStyle)style
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    [superView addSubview:tableView];
    tableView.frame = frame;
    tableView.backgroundColor = viewAndTableViewBackgroundColor;
    tableView.separatorColor = tableViewSeparateColor;
    return tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0.00001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

-(void)dealloc
{
    //防止子类忘记释放
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

@end
