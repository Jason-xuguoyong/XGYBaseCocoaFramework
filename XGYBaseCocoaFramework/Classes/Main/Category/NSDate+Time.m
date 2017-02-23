//
//  NSDate+Time.m
//  XGYiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)
/**
 *  获取当前时间的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串
 */
+ (NSString *)dateWithCurrentTimestamp
{
    //获取系统当前的时间NSDate
    NSDate* nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    //把1970至今的秒数换算成时间
    NSTimeInterval a=[nowDate timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%f", a ];
    NSInteger i = [timeString integerValue];
    NSString *timeStame = [NSString stringWithFormat:@"%ld",(long)i];
    // 转为字符型
    return timeStame;
    
}
/**
 *  通过一个时间戳获取取当前北京时间
 *
 *  @param timeStame       需要转换的时间戳
 *  @param formatterString 需要得到的背景时间格式
 *
 *  @return 返回北京时间
 */
+ (NSString *)dateFormatterTimeStringWithCurrentTimeStame:(NSString *)timeStame formatter:(NSString *)formatterString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterString];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeStame doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    
    return dateString;
}
/**
 *  获取取当前北京时间
 *
 *  @param formatter 时间的格式
 *
 *  @return 返回时间字符串
 */

+ (NSString *)dateCurrentStandarTimeWithFormatter:(NSString *)formatter
{
    NSString * locationString=[self dateFormatterTimeStringWithCurrentTimeStame:[self dateWithCurrentTimestamp] formatter:formatter];
    return locationString;
}

/**
 *  根据一个日期获取时间戳
 *
 *  @param dateString      北京时间 （2016/8/17 18:5:11 等）
 *  @param formatter 北京时间的格式
 *
 *  @return 返回时间戳字符串
 */
+ (NSString *)dateTimeStandarWithDate:(NSString *)dateString Formatter:(NSString *)formatter
{
    // 北京时间2016-06-28 13:20:00 000（可以把北京时间字符串转成北京时间戳、格林尼治时间）
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:formatter];
    NSDate *date = [matter dateFromString:dateString];
    
    NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return dateStr;
}
/**
 *  nsdata类型转换成时间字符串
 *  format:yyyy年MM月dd日  或者 yyyy-MM-dd HH:mm:ss.SSS 等
 */
+ (NSString*)dateToString:(NSString *)format byDate:(NSDate *)date
{
    
    NSDateFormatter *dateToStringFormatter=[[NSDateFormatter alloc] init];
    [dateToStringFormatter setDateFormat:format];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateToStringFormatter setTimeZone:GTMzone];
    return [dateToStringFormatter stringFromDate:date];
}
/**
 *  时间戳转换为时间的
 *
 *  @param timestamp 时间戳
 *
 *  @return  matter 标准时间字符串
 */
+ (NSString *)dateTimeStampChangesStandarTime:(NSString *)timestamp withFormatter:(NSString *)matter
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:matter];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;

}


/*2016-12-09T23:34:02+08:00  ==> */
+ (NSString  *)datepayDorTimeWithString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss zz:zz"];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    
    // 先将"+"替换成@" "
    dateString = [dateString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSDate *date = [dateFormatter dateFromString:dateString];

    return [NSDate dateToString:format byDate:date];
}




@end
