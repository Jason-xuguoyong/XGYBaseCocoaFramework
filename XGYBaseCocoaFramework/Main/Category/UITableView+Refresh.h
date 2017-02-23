//
//  UITableView+Refresh.h
//  RMTiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
@interface UITableView (Refresh)



/**
 给tableView增加上下拉刷新

 @param headerRefreshBlock 头部进入刷新的时候会调用的方法 如果传空，则头部不能刷新
 @param footerRefreshBlock  尾部进入刷新的时候会调用的方法 如果传空，则尾部不能刷新
 */
- (void)addRefreshForTableViewHeaderWithHeaderBlock:(void(^)(void))headerRefreshBlock footerWithFooterBlock:(void(^)(void))footerRefreshBlock;



#pragma mark ====一下的方法已经停止使用，请使用上面的方法代替
    
/**
 *  增加一个头部刷新控件
 *
 *  @param headerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在headerRefreshBlock里面
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock NS_DEPRECATED_IOS(2_0, 3_0, "请使用 addRefreshForTableViewHeaderWithHeaderBlock：footerWithFooterBlock来代替") __TVOS_PROHIBITED;

/**
 *  增加一个尾部刷新控件 （scrollView滚动到底部时候自动刷新）
 *  (这个方法的增加的控件，当用户滚动到scrollView或者是tableView的底部的时候会自动调用footerRefreshBlock)
 *
 *  @param footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifAutoFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock NS_DEPRECATED_IOS(2_0, 3_0, "请使用 addRefreshForTableViewHeaderWithHeaderBlock：footerWithFooterBlock来代替") __TVOS_PROHIBITED;

/**
 *  增加一个尾部刷新控件(不会自都进入刷新)
 *  （scrollView滚动到底部时候不会自动刷新，需要用户手动上拉加载）
 *
 *  @param footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifBackFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock NS_DEPRECATED_IOS(2_0, 3_0, "请使用 addRefreshForTableViewHeaderWithHeaderBlock：footerWithFooterBlock来代替") __TVOS_PROHIBITED;
/**
 *  同时增加一个头部和尾部的刷新控件（尾部会自动进入刷新)
 *
 *  @param headerRefreshBlock   进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 *  @param  footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshGifAutoFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock NS_DEPRECATED_IOS(2_0, 3_0, "请使用 addRefreshForTableViewHeaderWithHeaderBlock：footerWithFooterBlock来代替") __TVOS_PROHIBITED;


/**
 *  同时增加一个头部和尾部的刷新控件（尾部不会自动进入刷新)
 *
 *  @param headerRefreshBlock  进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 *  @param  footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshGifBackFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock NS_DEPRECATED_IOS(2_0, 3_0, "请使用 addRefreshForTableViewHeaderWithHeaderBlock：footerWithFooterBlock来代替") __TVOS_PROHIBITED;

/**
 增加上下拉刷新
 
 @param headerRefreshBlock 头部刷新会调用的方法
 @param footerRefreshBlock 尾部刷新会调用的方法
 */
- (void)addRefreshNormalHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshNormalFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock NS_DEPRECATED_IOS(2_0, 3_0, "请使用 addRefreshForTableViewHeaderWithHeaderBlock：footerWithFooterBlock来代替") __TVOS_PROHIBITED;
/**
 增加下拉刷新
 
 @param headerRefreshBlock 头部刷新会调用的方法
 */
- (void)addRefreshNormalHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock NS_DEPRECATED_IOS(2_0, 3_0, "请使用 addRefreshForTableViewHeaderWithHeaderBlock：footerWithFooterBlock来代替") __TVOS_PROHIBITED;

/**
 单纯增加上拉刷新
 
 @param footerRefreshBlocks 头部刷新会调用的方法
 */
- (void)addRefreshNormalFooterWithRefreshBlock:(void(^)(void))footerRefreshBlocks NS_DEPRECATED_IOS(2_0, 3_0, "请使用 addRefreshForTableViewHeaderWithHeaderBlock：footerWithFooterBlock来代替") __TVOS_PROHIBITED;
 
    

@end
