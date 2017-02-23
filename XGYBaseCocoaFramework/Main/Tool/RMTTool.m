//
//  RMTTool.m
//  RMTiOSApp
//
//  Created by Jason on 2016/11/11.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "RMTTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation RMTTool


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
+ (NSMutableAttributedString *)getDiffirentAtributeStringWithString:(NSString *)allString needChangeString:(NSString *)needChangeString changeColor:(UIColor *)color Font:(UIFont *)font
{
    NSMutableAttributedString *muString = [[NSMutableAttributedString alloc] initWithString:allString];
    if (allString != nil && ![allString isEqualToString:@""] &&needChangeString != nil && ![needChangeString isEqualToString:@""]) {
        
        NSRange rang = [allString rangeOfString:needChangeString];
        if (rang.location != NSNotFound) {
            
            if (color) {
                [muString addAttribute:NSForegroundColorAttributeName value:color range:rang];
            }
            
            if (font) {
                [muString addAttribute:NSFontAttributeName value:font range:rang];
            }
            
            return muString;
        }
        return muString;
    }
    
    return muString;
    
}

/**
 判断一个字符串是否为空
 
 @param string 需要判断的字符串
 @return 如果为空 返回YES
 */
+ (BOOL)isEmptyWithString:(NSString *)string
{
    if (!string) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]]) {
        //去掉空串
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (string.length == 0) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 手机号码
+ (BOOL)isMobilePhoneNumberRegex:(NSString *)phoneNumber{
    
    NSString *regex = @"^(1(([34578][0-9])|(45)|(47)|(7[6-8])))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:phoneNumber];
    return isValid;
}

#pragma mark - 座机(电话)
+ (BOOL)isMachinePhoneRegex:(NSString *)machinePhone{
    
    NSString *regex = @"(^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:machinePhone];
    return isValid;
}

#pragma mark - 验证是否是数字
+ (BOOL)isNumberRegex:(NSString *)number{
    
    if (!number) {
        return NO;
    }
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:number];
    return isValid;

}

#pragma mark ====验证是否是数字或者是字母
+  (BOOL)isNumberStringOrZImuString:(NSString *)string
{
    if (!string) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:string];
    return isValid;

}

#pragma mark --验证是否是中文数字或者是字母
+ (BOOL)isChineseOrNumber:(NSString *)string
{
    if (!string) {
        return NO;
    }
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:string];
    return isValid;
}


#pragma mark --验证是否包含Emoj表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

#pragma mark - 只能输入点和数字
+ (BOOL)validateFloatString:(NSString *)value
{
    
    NSString *phoneRegex = @"^[0-9]*|\\.";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:value];
}



#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) value
{
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([value length] != 18) {
        
        return NO;
        
    }
    
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    
    NSString *leapMmdd = @"0229";
    
    NSString *year = @"(19|20)[0-9]{2}";
    
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![regexTest evaluateWithObject:value]) {
        
        return NO;
        
    }
    
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    
    NSInteger remainder = summary % 11;
    
    NSString *checkBit = @"";
    
    NSString *checkString = @"10X98765432";
    
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}


#pragma 判断是不是100的整数倍
+ (BOOL)checkOneHundredNumberWithString:(NSString *)number
{
    int idex = [number intValue];
    if (idex >0 && idex%100 ==0) {
        return YES;
    }
    return NO;
    
}


/**
 *  用户id进行sha加密
 */
+ (NSString *)getShaEncryptWithString:(NSString *)string {
    
    if (!string) {
        string = @"123456";
    }
    
    NSMutableString *mStr =[[NSMutableString alloc] initWithString:string];

    
    const char *cStr = [mStr cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cStr length:mStr.length];
    
    
    
    uint8_t diget[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)strlen(cStr), diget);
    
    NSMutableString *s = [[NSMutableString alloc] init];
    
    for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i ++) {
        [s appendFormat:@"%02X",diget[i]];
    }
    
    
    return [s lowercaseString];
    
}



/**
 判断后台数据是不是数组，如果不是则返回一个数组
 
 @param responsObj 后台数据
 */
+ (NSArray *)getNSArrayClass:(id)responsObj
{
    if (!responsObj) {
        return nil;
    }
    if ([responsObj isKindOfClass:[NSArray class]]) {
        return responsObj;
    }else
    {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responsObj options:NSJSONReadingMutableContainers error:nil];
        
        if ([array isKindOfClass:[NSArray class]]) {
            return array;
        }
        return nil;
    }
}

/**
 判断后台数据是不是字典，如果不是则返回一个字典
 
 @param responsObj 后台数据
 */
+ (NSDictionary *)getDictionaryClass:(id)responsObj
{
    if (!responsObj) {
        return nil;
    }
    if ([responsObj isKindOfClass:[NSDictionary class]]) {
        return responsObj;
    }else
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responsObj options:NSJSONReadingMutableContainers error:nil];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            return dict;
        }
        return nil;
    }
}

/**
 判断后台数据是不是string，如果不是则返回一个string
 
 @param responsObj 后台数据
 */
+ (NSString *)getStringClass:(id)responsObj
{
    if (!responsObj) {
        return nil;
    }
    if ([responsObj isKindOfClass:[NSString class]]) {
        return responsObj;
    }else
    {
        NSString *string =[[NSString alloc] initWithData:responsObj encoding:NSUTF8StringEncoding];
        return string;
    }
}
/**
 拼接前缀到地址
 
 @param imageString 需要拼接的图片地址 customer/xxx
 @return 拼接好的字符串 http://xxx/customer/xxx
 */
+ (NSString *)getCompleteImageUrlStringWithImagestring:(NSString *)imageString
{
    return nil;

}



/**
 根据剩余时间获取00：00：00时分秒
 
 @param timeout 剩余时间
 @return 00：00：00时分秒
 */
+ (NSString *)getTimeStringWithleftTime:(CGFloat)timeout
{
    NSInteger hours = (NSInteger)(timeout / 3600);
    NSInteger minute = (NSInteger)(timeout - hours * 3600) / 60;
    NSInteger second = timeout - hours * 3600 - minute * 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",(int)hours,(int)minute,(int)second];


}




#pragma mark-----正则表达式验证银行卡号
+ (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

#pragma 正则匹密码,6-16位的数字字母
+ (BOOL)checkPasswordNumber : (NSString *) number
{
    NSString *regex = @"^[a-zA-Z0-9]{6,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:number];
    return isValid;
    
}

#pragma 正则匹配用户姓名,1-15位的中文或英文或者是数字
+ (BOOL)checkUserNikeName:(NSString *)userName
{
    NSString *regex = @"^[0-9A-Za-z\\u4e00-\\u9fa5]{1,15}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:userName];
    return isValid;
}


@end
