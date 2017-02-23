//
//  XGYActionSheet.m
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/21.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "XGYActionSheet.h"
#import "XGYMenueView.h"
@interface XGYActionSheet ()

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *cancelButtonTitle;
@property (nonatomic,strong) NSArray *titlesArray;
@property (nonatomic,strong) NSNumber *destructiveButtonIndex;
@property (nonatomic,strong) void (^buttonClickBlock)(NSString *clickButtonTitle,int buttonIndex);
@property (nonatomic,strong) void (^cancelButtonClickBlock)(id data);

@property (nonatomic,strong) UIView *menueBackgroudView;
@property (nonatomic,strong) XGYMenueView *menueView;
@property (nonatomic,assign) CGFloat totalHeight;
@property (nonatomic,strong) UIButton *cancelButton;
@end


@implementation XGYActionSheet


/**
 初始化方法
 
 @param title 标题
 @param cancelButtonTitle 取消按钮的标题
 @param titlesArray 其他按钮的标题 形式 @[@"从相册选择",@"拍照",@"其他",...]
 @param index 需要着重显示的文字在数组titlesArray中的下标 如果不需要请传 10086
 @param cancelButtonClickBlock 取消按钮点击的回调
 @param buttonClickBlock 所有按钮点击的回调 将当前点击的按钮和按钮在titlesArray中的下标返回
 */
- (instancetype)initActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle buttonTitleArray:(NSArray *)titlesArray  destructiveButtonIndex:(NSNumber *)index cancelButtonClick:(void(^)(UIButton *clickButton))cancelButtonClickBlock buttonClickBlock:(void(^)(NSString *clickButtonTitle,int buttonIndex))buttonClickBlock
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        _title  =title;
        _destructiveButtonIndex = index;
        _cancelButtonTitle = cancelButtonTitle;
        _titlesArray = titlesArray;
        _buttonClickBlock = buttonClickBlock;
        _cancelButtonClickBlock = cancelButtonClickBlock;
        [self initMenuneBackgroundView];
        [self showMenueViewWithAnimation:YES];
    }
    return self;
}
- (void) initMenuneBackgroundView
{
    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(d_screen_width - 60, MAXFLOAT);
    
    CGSize placehoderSize = [_title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    CGFloat totalHight = placehoderSize.height + 20/*上下边距*/ + _titlesArray.count *60 + 20 + 60;
    CGFloat menueViewHeight = placehoderSize.height + 20 + _titlesArray.count *60;
    if (totalHight >d_screen_height - 100) {
        totalHight = d_screen_height - 100;
        menueViewHeight = d_screen_height - 100 - 80;
    }
    
    self.totalHeight = totalHight;

    self.menueBackgroudView = [[UIView alloc] initWithFrame:CGRectMake(15, d_screen_height, d_screen_width - 30, totalHight)];
    [self addSubview:self.menueBackgroudView];
    
    self.menueView = [[XGYMenueView alloc] initWithMessageTitle:_title buttonTitleArray:_titlesArray Frame:CGRectMake(0, 0, self.menueBackgroudView.width, menueViewHeight) destructiveButtonIndex:_destructiveButtonIndex];
    __weak typeof(self)weakself = self;
    self.menueView.didClickButtonBlock = ^(NSString *click, int index)
    {
        [weakself hiddeMenueViewWithAnimation];
        if (weakself.buttonClickBlock) {
            weakself.buttonClickBlock(click,index);
        }
        
    };
    [self.menueBackgroudView addSubview:self.menueView];
    
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    self.cancelButton.layer.cornerRadius = 15.0f;
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.backgroundColor =[[UIColor whiteColor] colorWithAlphaComponent:0.95];
    [self.cancelButton setTitleColor:UIColorFromRGB(0x007aff) forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.menueBackgroudView addSubview:self.cancelButton];
    self.cancelButton.sd_layout.leftEqualToView(self.cancelButton).rightEqualToView(self.menueBackgroudView).bottomEqualToView(self.menueBackgroudView).offset(-10).heightIs(60);
    
    
}
/**
 显示ActionSheet的方法
 */
- (void)showMenueViewWithAnimation:(BOOL)annimation
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
            self.menueBackgroudView.transform = CGAffineTransformMakeTranslation(0,-self.totalHeight);
        }];
    }
    
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

- (void)cancelButtonClick:(UIButton *)sender
{
    [self hiddeMenueViewWithAnimation];
    if (self.cancelButtonClickBlock) {
        self.cancelButtonClickBlock(sender);
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    UIView *view = touch.view;
    if ([view isKindOfClass:[XGYActionSheet class]]) {
        [self hiddeMenueViewWithAnimation];
    }
}
@end
