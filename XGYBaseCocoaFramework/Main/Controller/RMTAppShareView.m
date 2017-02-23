//
//  RMTAppShareView.m
//  RMTEvaluationRCode
//
//  Created by Jason on 2017/2/21.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "RMTAppShareView.h"

#import <Accelerate/Accelerate.h>
//＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

#define itemW ((d_screen_width - 10)/4.0f)

@interface RMTAppShareView ()

/**
 分享的URL
 */
@property (nonatomic,strong) NSString *shareURL;

/**
 分享的标题
 */
@property (nonatomic,strong) NSString *title;

/**
 分享的内容
 */
@property (nonatomic,strong) NSString *shareConten;

/**
 分享的图标
 */
@property (nonatomic,strong) NSString *shareIcon;

/**
 分享的白色背景
 */
@property (nonatomic,strong) UIView *menueBackgroudView;

/**
 显示“分享至”label
 */
@property (nonatomic,strong) UILabel *tLabel;

/**
 取消按钮
 */
@property (nonatomic,strong) UIButton *cancelButton;


@end



@implementation RMTAppShareView


/**
 初始化方法

 @param shareURL 分享的URL地址
 @param title 分享的标题
 @param shareConten 分享的文字内容
 @param shareIcon 分享的图片
 @return 返回创建好的对象
 */
- (instancetype)initWithShareURLString:(NSString *)shareURL shareTitle:(NSString *)title shareConten:(NSString *)shareConten shareIcon:(NSString *)shareIcon
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        _shareURL = shareURL;
        _title = title;
        _shareConten = shareConten;
        _shareIcon = shareIcon;
        [self initBGView];
        
    }
    return self;
}

- (void)initBGView
{
    [self addSubview:self.menueBackgroudView];
}


/**
 显示分享View的方法
 */
- (void)showShareViewWithAnimation:(BOOL)annimation
{
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:self];
    if (annimation) {
        self.alpha = 0.0f;
        // 1.动画时间
        CGFloat duration = 0.25f;
        // 2.动画
        [UIView animateWithDuration:duration animations:^{
            self.alpha = 1.0f;
            self.menueBackgroudView.transform = CGAffineTransformMakeTranslation(0,-self.menueBackgroudView.height);
        }];
    }
    
}
/**
 分享按钮的背面的白色的View
 */
-(UIView *)menueBackgroudView
{
    if (!_menueBackgroudView) {
        _menueBackgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, d_screen_height, d_screen_width, 55 +20+40+5+10+itemW)];
        _menueBackgroudView.backgroundColor = [UIColor whiteColor];
        self.tLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, d_screen_width - 30, 40)];
        [_menueBackgroudView addSubview:self.tLabel];
        self.tLabel.text =@"分享至";
        self.tLabel.textAlignment = NSTextAlignmentCenter;
        self.tLabel.textColor = UIColorFromRGB(0x979797);
        self.tLabel.font = [UIFont systemFontOfSize:18.0f];
        
        NSArray *arr = @[@"朋友圈",@"微信好友",@"微博",@"QQ好友"];
        NSArray *imageNameArr = @[@"share_wechat_space_icon",@"share_wechat_icon",@"share_weibo_icon",@"share_QQ_friend_icon"];
        
        for (NSInteger i = 0; i < arr.count; i ++) {
            
            UIButton *btn = [UIButton creatCustomButtonNormalStateWithTitile:arr[i] titleFont:[UIFont systemFontOfSize:13.0f] titleColor:UIColorFromRGB(0x000000) butttonImage:[UIImage imageNamed:imageNameArr[i]] backgroundImage:nil backgroundColor:[UIColor clearColor] clickThingTarget:self action:@selector(shareImageViewTouchAction:)];
            btn.tag = 100 +i;
            btn.frame = CGRectMake(5 + i * itemW,CGRectGetMaxY(self.tLabel.frame), itemW, itemW+10);
            [btn setButtonImageAndTitleAlignmentCenter];
            [_menueBackgroudView addSubview:btn];
        }
        
        self.cancelButton = [UIButton creatCustomButtonNormalStateWithTitile:@"取  消" titleFont:[UIFont systemFontOfSize:19.0f] titleColor:UIColorFromRGB(0x333333) butttonImage:nil backgroundImage:nil backgroundColor:viewAndTableViewBackgroundColor clickThingTarget:self action:@selector(cancelBUttonClick:)];
        [_menueBackgroudView addSubview:self.cancelButton];
        self.cancelButton.layer.cornerRadius = 5.0f;
        self.cancelButton.layer.masksToBounds = YES;
        self.cancelButton.sd_layout.leftEqualToView(_menueBackgroudView).offset(20).rightEqualToView(_menueBackgroudView).offset(-20).bottomEqualToView(_menueBackgroudView).offset(-20).heightIs(50.0f);
        
        
        
    }
    return _menueBackgroudView;
}


- (void)shareImageViewTouchAction:(UIButton *)sender
{
    
    SSDKPlatformType type = 200;
    switch (sender.tag -100) {
        case 0://朋友圈
        {
            type = SSDKPlatformSubTypeWechatTimeline;
            
        }
            break;
        case 1://微信好友
        {
            
            type = SSDKPlatformSubTypeWechatSession;
        }
            break;
        case 2://微博
        {
            type = SSDKPlatformTypeSinaWeibo;
            
            
        }
            break;
        case 3://QQ好友
        {
            type = SSDKPlatformSubTypeQQFriend;
            
            
        }
            break;
        case 4://QQ空间
        {
            type = SSDKPlatformSubTypeQZone;
            
        }
            break;
            
        default:
            break;
    }
    
    if (type == 200) {
        return;
    }
    
    if (!self.shareURL) {
        [RMTMessageTool showMessage:@"分享链接不能为空！"];
        return;
    }
    
    [RMTMessageTool showLoadingHUD];
    self.shareURL=[self.shareURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:self.shareConten?self.shareConten:@"" images:@[self.shareIcon?self.shareIcon:[UIImage imageNamed:@"app_icon"]] url:[NSURL URLWithString:self.shareURL] title:self.title?self.title:@"" type:SSDKContentTypeAuto];
    
    
    if (type ==SSDKPlatformTypeSinaWeibo && [WeiboSDK isCanShareInWeiboAPP]) {
        [shareParams SSDKEnableUseClientShare];
    }
    [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        [RMTMessageTool hideLoadingHUD];
        switch (state) {
            case SSDKResponseStateBegin:
            {
                
            }
                break;
            case SSDKResponseStateSuccess:
            {
                
                [RMTMessageTool showMessage:@"分享成功"];
                
            }
                break;
            case SSDKResponseStateCancel:
            {
                
            }
                break;
            case SSDKResponseStateFail:
            {
                [RMTMessageTool showMessage:@"分享失败，请检查网络连接~"];
            }
                break;
                
            default:
                break;
        }
        
        
    }];
}

- (void)hiddeMenueViewWithAnimation
{
    // 1.动画时间
    CGFloat duration = 0.25f;
    //2 动画
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.0f;
        self.menueBackgroudView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

/**
 取消按钮的点击事件
 */
- (void)cancelBUttonClick:(id)sender
{
    [self hiddeMenueViewWithAnimation];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    UIView *view = touch.view;
    if ([view isKindOfClass:[RMTAppShareView class]]) {
        [self hiddeMenueViewWithAnimation];
    }
}
@end
