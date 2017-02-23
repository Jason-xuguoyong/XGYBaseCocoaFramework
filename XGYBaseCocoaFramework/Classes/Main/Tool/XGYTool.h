//
//  XGYTool.h
//  XGYiOSApp
//
//  Created by Jason on 2016/11/11.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGYTool : NSObject
/**
 *  改变一个label内的字体的颜色
 *
 *  @param allString        整个字符串
 *  @param needChangeString 需要改变颜色的字符串
 *  @param color            改变的颜色
 *  @param font             改变的字体大小
 *
 *  @return 返回一个改变后的字符串
 */

+ (NSMutableAttributedString *)getDiffirentAtributeStringWithString:(NSString *)allString needChangeString:(NSString *)needChangeString changeColor:(UIColor *)color Font:(UIFont *)font;

/**
 判断一个字符串是否为空

 @param string 需要判断的字符串
 @return 如果不为空 返回YES
 */
+ (BOOL)isEmptyWithString:(NSString *)string;
/**
 *  用户id进行sha加密
 */
+ (NSString *)getShaEncryptWithString:(NSString *)string;


/**
 判断后台数据是不是数组，如果不是则返回一个数组

 @param responsObj 后台数据
 */
+ (NSArray *)getNSArrayClass:(id)responsObj;

/**
 判断后台数据是不是string，如果不是则返回一个string
 
 @param responsObj 后台数据
 */
+ (NSString *)getStringClass:(id)responsObj;



/**
 判断后台数据是不是字典，如果不是则返回一个字典
 
 @param responsObj 后台数据
 */
+ (NSDictionary *)getDictionaryClass:(id)responsObj;


/**
 根据剩余时间获取00：00：00时分秒

 @param timeout 剩余时间
 @return 00：00：00时分秒
 */
+ (NSString *)getTimeStringWithleftTime:(CGFloat)timeout;

/**
 拼接前缀到地址

 @param imageString 需要拼接的图片地址 customer/xxx
 @return 拼接好的字符串 http://xxx/customer/xxx
 */
+ (NSString *)getCompleteImageUrlStringWithImagestring:(NSString *)imageString;

#pragma mark-----正则表达式验证银行卡号
+ (BOOL) checkCardNo:(NSString*) cardNo;
#pragma mark - 手机号码
+ (BOOL)isMobilePhoneNumberRegex:(NSString *)phoneNumber;
#pragma mark - 是否是座机
+ (BOOL)isMachinePhoneRegex:(NSString *)machinePhone;
#pragma mark - 验证是否是数字
+ (BOOL)isNumberRegex:(NSString *)number;
#pragma mark - 验证是否是只有两位小数的数字
+ (BOOL)validateFloatString:(NSString *)value;
#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) value;
#pragma 判断是不是100的整数倍
+ (BOOL)checkOneHundredNumberWithString:(NSString *)number;
#pragma 正则匹员工号,6-16位的数字
+ (BOOL)checkPasswordNumber : (NSString *)number;
#pragma 正则匹配用户姓名,1-15位的中文或英文
+ (BOOL)checkUserNikeName:(NSString *)userName;
#pragma mark --验证是否是中文数字或者是字母
+ (BOOL)isChineseOrNumber:(NSString *)string;
#pragma mark --验证是否包含Emoj表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
#pragma mark ====验证是否是数字或者是字母
+  (BOOL)isNumberStringOrZImuString:(NSString *)string;
@end
