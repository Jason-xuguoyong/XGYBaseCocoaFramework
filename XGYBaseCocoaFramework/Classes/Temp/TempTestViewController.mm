//
//  TempTestViewController.m
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/8.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "TempTestViewController.h"
@interface TempTestViewController ()

@end

@implementation TempTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self launchSDK];
  
    
}
- (void)launchSDK {
    
    // 商户需要从服务端获取
//    NSString* sign = @"XusqllQQjawQPF2pmFelPuWrS6zLwLpTzKG5HoSNDyYEshqdjjs1MgOAL7LP8RHceCLu5PPh5SbKAM0ghtR5e%2FvA25eeOY1V4WAVtQq%2FGer197sUNzJsXONAgGAT1ukwJ%2FTIGew384iqRXIf4nV%2BcUjCmlWTC7NXkwKgBE%2FrNdo%3D";
//    
//    NSString* params = @"ApO88WwMflzmDXYX1aTdnz0L3%2FUF8kHXtd5GF1tFJKzDSo2tmOcRmaoDYGiSNUpVyx4jqWl2HgM30v0hOXNDUlKA5ZGrExYmT5qMPbtplGFHpJe4k%2ByZHHIz6CJFuYcq8b2fGMg%2FXAH0Hq2XV2Yhu9ZOahx5W8ryJPnBh8kt1ks%3D";
//    NSString* appId = @"1000100";
//    
//    [[ALCreditService sharedService] queryUserAuthReq:appId sign:sign params:params extParams:nil selector:@selector(result:) target:self];
    
    [XGYDataServiceTool requestDataWithMethod:HttpRequestMethodType_POST url:@"" parma:nil isJason:YES showErrorMessage:YES showHUD:NO refreshTableView:nil success:^(id responseObj) {
        
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
    
    
    
}
- (void)result:(NSMutableDictionary*)dic{
    NSLog(@"result ");
    
    NSString* system  = [[UIDevice currentDevice] systemVersion];
    if([system intValue]>=7){
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
}

@end
