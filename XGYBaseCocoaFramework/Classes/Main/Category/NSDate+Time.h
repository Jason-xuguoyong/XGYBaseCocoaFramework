//
//  NSDate+Time.h
//  XGYiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Time)
/**
 *  获取当前时间的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串
 */
+ (NSString *)dateWithCurrentTimestamp;
/**
 *  通过一个时间戳获取取当前北京时间
 *
 *  @param timeStame       需要转换的时间戳
 *  @param formatterString 需要得到的背景时间格式
 *
 *  @return 返回北京时间
 */
+ (NSString *)dateFormatterTimeStringWithCurrentTimeStame:(NSString *)timeStame formatter:(NSString *)formatterString;
/**
 *  获取取当前北京时间
 *
 *  @param formatter 时间的格式
 *
 *  @return 返回时间字符串
 */

+ (NSString *)dateCurrentStandarTimeWithFormatter:(NSString *)formatter;

/**
 *  根据一个日期获取时间戳
 *
 *  @param dateString      北京时间 （2016/8/17 18:5:11 等）
 *  @param formatter 北京时间的格式
 *
 *  @return 返回时间戳字符串
 */
+ (NSString *)dateTimeStandarWithDate:(NSString *)dateString Formatter:(NSString *)formatter;


/**
 nsdata类型转换成时间字符串
 format:yyyy年MM月dd日  或者 yyyy-MM-dd HH:mm:ss.SSS 等
 */
+(NSString*)dateToString:(NSString *)format byDate:(NSDate *)date;
/**
 *  时间戳转换为时间的方法
 *
 *  @param timestamp 时间戳
 *
 *  @return  matter 标准时间字符串
 */
+ (NSString *)dateTimeStampChangesStandarTime:(NSString *)timestamp withFormatter:(NSString *)matter;
/*2016-12-09T10:40:25Z  ==> */
+ (NSString  *)datepayDorTimeWithString:(NSString *)dateString format:(NSString *)format;
@end
