//
//  SRAlertView.m
//  SRAlertViewDemo
//
//  Created by 郭伟林 on 16/7/8.
//  Copyright © 2016年 SR. All rights reserved.
//

#import "XGYAlertView.h"
#import "XGYBlurView.h"

#pragma mark - Screen Frame

#define SCREEN_BOUNDS          [UIScreen mainScreen].bounds
#define SCREEN_WIDTH           [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT          [UIScreen mainScreen].bounds.size.height
#define SCREEN_ADJUST(Value)   SCREEN_WIDTH * (Value) / 375.0f

#pragma mark - Color

#define COLOR_RGB(R, G, B)              [UIColor colorWithRed:(R/255.0f) green:(G/255.0f) blue:(B/255.0f) alpha:1.0f]
#define COLOR_RANDOM                    COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define UICOLOR_FROM_HEX_ALPHA(RGBValue, Alpha) [UIColor \
colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0xFF00) >> 8))/255.0 \
blue:((float)(RGBValue & 0xFF))/255.0 alpha:Alpha]

#define UICOLOR_FROM_HEX(RGBValue) [UIColor \
colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0xFF00) >> 8))/255.0 \
blue:((float)(RGBValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - Use Color

#define kTitleLabelColor                UICOLOR_FROM_HEX_ALPHA(0x000000, 1.0)
#define kMessageLabelColor              UICOLOR_FROM_HEX_ALPHA(0x313131, 1.0)

#define kBtnNormalTitleColor            UICOLOR_FROM_HEX_ALPHA(0x4A4A4A, 1.0)
#define kBtnHighlightedTitleColor       UICOLOR_FROM_HEX_ALPHA(0x4A4A4A, 1.0)
#define kBtnHighlightedBackgroundColor  UICOLOR_FROM_HEX_ALPHA(0xF76B1E, 0.15)

#define kLineBackgroundColor            [UIColor colorWithRed:1.00 green:0.92 blue:0.91 alpha:1.00]

#pragma mark - Use Frame

#define kAlertViewW             275.0f
#define kAlertViewTitleH        20.0f
#define kAlertViewBtnH          50.0f
#define kAlertViewMessageMinH   0.0f

#define kTitleFont      [UIFont boldSystemFontOfSize:SCREEN_ADJUST(18)];
#define kMessageFont    [UIFont systemFontOfSize:SCREEN_ADJUST(15)];
#define kBtnTitleFont   [UIFont systemFontOfSize:SCREEN_ADJUST(16)];

@interface XGYAlertView ()

@property (nonatomic, weak  ) id<XGYAlertViewDelegate>   delegate;
@property (nonatomic, copy  ) AlertViewDidSelectAction  selectAction;

@property (nonatomic, strong) UIView     *alertView;
@property (nonatomic, strong) UIView     *coverView;
@property (nonatomic, strong) XGYBlurView *blurView;

@property (nonatomic, copy  ) NSString   *title;
@property (nonatomic, strong) UILabel    *titleLabel;

@property (nonatomic, copy  ) NSString   *message;
@property (nonatomic, strong) UILabel    *messageLabel;

@property (nonatomic, copy  ) NSString   *leftActionTitle;
@property (nonatomic, strong) UIButton   *leftAction;

@property (nonatomic, copy  ) NSString   *rightActionTitle;
@property (nonatomic, strong) UIButton   *rightAction;

@end

@implementation XGYAlertView

#pragma mark - BLOCK

+ (void)sr_showAlertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                  leftActionTitle:(NSString *)leftActionTitle
                 rightActionTitle:(NSString *)rightActionTitle
                   animationStyle:(AlertViewAnimationStyle)animationStyle
                     selectAction:(AlertViewDidSelectAction)selectAction;
{
    XGYAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                         leftActionTitle:leftActionTitle
                                        rightActionTitle:rightActionTitle
                                          animationStyle:animationStyle
                                            selectAction:selectAction];
    [alertView show];
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              leftActionTitle:(NSString *)leftActionTitle
             rightActionTitle:(NSString *)rightActionTitle
               animationStyle:(AlertViewAnimationStyle)animationStyle
                 selectAction:(AlertViewDidSelectAction)selectAction
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _blurCurrentBackgroundView = YES;
        _title             = title;
        _message           = message;
        _leftActionTitle   = leftActionTitle;
        _rightActionTitle  = rightActionTitle;
        _animationStyle    = animationStyle;
        _selectAction      = selectAction;
        [self setupAlertView];
    }
    return self;
}

#pragma mark - DELEGATE

+ (void)sr_showAlertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                  leftActionTitle:(NSString *)leftActionTitle
                 rightActionTitle:(NSString *)rightActionTitle
                   animationStyle:(AlertViewAnimationStyle)animationStyle
                         delegate:(id<XGYAlertViewDelegate>)delegate
{
    XGYAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                         leftActionTitle:leftActionTitle
                                        rightActionTitle:rightActionTitle
                                          animationStyle:animationStyle
                                                delegate:delegate];
    [alertView show];
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              leftActionTitle:(NSString *)leftActionTitle
             rightActionTitle:(NSString *)rightActionTitle
               animationStyle:(AlertViewAnimationStyle)animationStyle
                     delegate:(id<XGYAlertViewDelegate>)delegate
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _blurCurrentBackgroundView = YES;
        _title             = title;
        _message           = message;
        _leftActionTitle   = leftActionTitle;
        _rightActionTitle  = rightActionTitle;
        _animationStyle    = animationStyle;
        _delegate          = delegate;
        [self setupAlertView];
    }
    return self;
}

#pragma mark - Setup

- (XGYBlurView *)blurView {
    
    if (!_blurView) {
        _blurView = [[XGYBlurView alloc] initWithFrame:SCREEN_BOUNDS];
        _blurView.tintColor = [UIColor clearColor];
        _blurView.dynamic = NO;
        _blurView.blurRadius = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:_blurView];
    }
    return _blurView;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        [self insertSubview:({
            _coverView = [[UIView alloc] initWithFrame:self.bounds];
            _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            _coverView.alpha = 0;
            _coverView;
        }) atIndex:0];
    }
    return _coverView;
}

- (void)setupAlertView {
    
    [self addSubview:({
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor     = [UIColor whiteColor];
        _alertView.layer.cornerRadius  = 10.0;
        _alertView.layer.masksToBounds = YES;
        _alertView;
    })];
    
    CGFloat verticalMargin = 20;//垂直控件之间的距离
    if (_title) {
        [_alertView addSubview:({
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, verticalMargin, kAlertViewW, kAlertViewTitleH)];
            _titleLabel.text          = _title;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.textColor     = kTitleLabelColor;
            _titleLabel.font          = kTitleFont;
            _titleLabel;
        })];
    }
    
    CGFloat messageLabelSpacing = 20; //详细信息
    [_alertView addSubview:({
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor whiteColor];
        _messageLabel.textColor       = kMessageLabelColor;
        _messageLabel.font            = kMessageFont;
        _messageLabel.numberOfLines   = 0;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        CGSize maxSize = CGSizeMake(kAlertViewW - messageLabelSpacing * 2, MAXFLOAT);
        _messageLabel.text = @"one";
        
        CGSize tempSize    = [_messageLabel sizeThatFits:maxSize];
        _messageLabel.text = _message;
        CGSize expectSize  = [_messageLabel sizeThatFits:maxSize];
        if (expectSize.height == tempSize.height) {
            // if just only one line then set textAlignment is NSTextAlignmentCenter.
            _messageLabel.textAlignment = NSTextAlignmentCenter;
        }
        [_messageLabel sizeToFit];
        
        
        CGFloat messageLabH = expectSize.height < kAlertViewMessageMinH ? kAlertViewMessageMinH : expectSize.height;
        _messageLabel.frame = CGRectMake(messageLabelSpacing, CGRectGetMaxY(_titleLabel.frame) + verticalMargin,kAlertViewW - messageLabelSpacing * 2, messageLabH);
        _messageLabel;
    })];
    
    CGFloat maxY = CGRectGetMaxY(_messageLabel.frame) + kAlertViewBtnH + verticalMargin;
    if (!_message ||[_message isEqualToString:@""]) {
       maxY =CGRectGetMaxY(_titleLabel.frame) + kAlertViewBtnH + verticalMargin;
    }
    _alertView.frame  = CGRectMake(0, 0, kAlertViewW,maxY );
    _alertView.center = self.center;
    
    CGFloat btnY = _alertView.frame.size.height - kAlertViewBtnH;
    if (_leftActionTitle) {
        [_alertView addSubview:({
            _leftAction = [UIButton buttonWithType:UIButtonTypeCustom];
            _leftAction.tag = AlertViewActionTypeLeft;
            _leftAction.titleLabel.font = kBtnTitleFont;
            [_leftAction setTitle:_leftActionTitle forState:UIControlStateNormal];
            [_leftAction setTitleColor:kBtnNormalTitleColor forState:UIControlStateNormal];
            [_leftAction setTitleColor:kBtnHighlightedTitleColor forState:UIControlStateHighlighted];
            [_leftAction setBackgroundImage:[self imageWithColor:kBtnHighlightedBackgroundColor] forState:UIControlStateHighlighted];
            [_leftAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_leftAction];
            if (_rightActionTitle) {
                _leftAction.frame = CGRectMake(0, btnY, kAlertViewW * 0.5, kAlertViewBtnH);
            } else {
                _leftAction.frame = CGRectMake(0, btnY, kAlertViewW, kAlertViewBtnH);
            }
            _leftAction;
        })];
    }
    
    if (_rightActionTitle) {
        [_alertView addSubview:({
            _rightAction = [UIButton buttonWithType:UIButtonTypeCustom];
            _rightAction.tag = AlertViewActionTypeRight;
            _rightAction.titleLabel.font = kBtnTitleFont;
            [_rightAction setTitle:_rightActionTitle forState:UIControlStateNormal];
            [_rightAction setTitleColor:kBtnNormalTitleColor forState:UIControlStateNormal];
            [_rightAction setTitleColor:kBtnHighlightedTitleColor forState:UIControlStateHighlighted];
            [_rightAction setBackgroundImage:[self imageWithColor:kBtnHighlightedBackgroundColor] forState:UIControlStateHighlighted];
            [_rightAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_rightAction];
            if (_rightActionTitle) {
                _rightAction.frame = CGRectMake(kAlertViewW * 0.5, btnY, kAlertViewW * 0.5, kAlertViewBtnH);
            } else {
                _rightAction.frame = CGRectMake(0, btnY, kAlertViewW, kAlertViewBtnH);
            }
            _rightAction;
        })];
    }
    
    if (_leftActionTitle && _rightActionTitle) {
        UIView *line1 = [[UIView alloc] init];
        line1.frame = CGRectMake(0, btnY, kAlertViewW, 1);
        line1.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line1];
        
        UIView *line2 = [[UIView alloc] init];
        line2.frame = CGRectMake(kAlertViewW * 0.5, btnY, 1, kAlertViewBtnH);
        line2.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line2];
    } else {
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, btnY, kAlertViewW, 1);
        line.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line];
    }
}

#pragma mark - Actions

- (void)btnAction:(UIButton *)btn {
    
    if (self.selectAction) {
        self.selectAction(btn.tag);
    }
    if ([self.delegate respondsToSelector:@selector(alertViewDidSelectAction:)]) {
        [self.delegate alertViewDidSelectAction:btn.tag];
    }
    
    [self dismiss];
}

#pragma mark - Animations

- (void)show {
    
    if (!_blurCurrentBackgroundView) {
        [self coverView];
    } else {
        [self blurView];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    if (!_blurCurrentBackgroundView) {
        [UIView animateWithDuration:0.65 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _coverView.alpha = 1.0;
                         } completion:nil];
    } else {
        _blurView.blurRadius = 10;
    }
    
    switch (self.animationStyle) {
        case AlertViewAnimationNone:
        {
            // No animation
            break;
        }
        case AlertViewAnimationZoom:
        {
            [self.alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                             } completion:nil];
            break;
        }
        case AlertViewAnimationTopToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(self.center.x, -self.alertView.frame.size.height);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case AlertViewAnimationDownToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(self.center.x, SCREEN_HEIGHT);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case AlertViewAnimationLeftToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(-kAlertViewW, self.center.y);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case AlertViewAnimationRightToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(SCREEN_WIDTH + kAlertViewW, self.center.y);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
    }
}

- (void)dismiss {

    [self.alertView removeFromSuperview];
    
    if (!_blurCurrentBackgroundView) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _coverView.alpha = 0;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    } else {
        [_blurView removeFromSuperview];
        [self removeFromSuperview];
    }
}

#pragma mark - Other

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Public interface

- (void)setAnimationStyle:(AlertViewAnimationStyle)animationStyle {
    
    if (_animationStyle == animationStyle) {
        return;
    }
    _animationStyle = animationStyle;
}

- (void)setBlurCurrentBackgroundView:(BOOL)blurCurrentBackgroundView {
    
    if (_blurCurrentBackgroundView == blurCurrentBackgroundView) {
        return;
    }
    _blurCurrentBackgroundView = blurCurrentBackgroundView;
}

- (void)setActionWhenHighlightedTitleColor:(UIColor *)actionWhenHighlightedTitleColor {
    
    if (_actionWhenHighlightedTitleColor == actionWhenHighlightedTitleColor) {
        return;
    }
    _actionWhenHighlightedTitleColor = actionWhenHighlightedTitleColor;
    
    [self.leftAction  setTitleColor:actionWhenHighlightedTitleColor forState:UIControlStateHighlighted];
    [self.rightAction setTitleColor:actionWhenHighlightedTitleColor forState:UIControlStateHighlighted];
}

- (void)setActionWhenHighlightedBackgroundColor:(UIColor *)actionWhenHighlightedBackgroundColor {
    
    if (_actionWhenHighlightedBackgroundColor == actionWhenHighlightedBackgroundColor) {
        return;
    }
    _actionWhenHighlightedBackgroundColor = actionWhenHighlightedBackgroundColor;
    
    [self.leftAction  setBackgroundImage:[self imageWithColor:actionWhenHighlightedBackgroundColor] forState:UIControlStateHighlighted];
    [self.rightAction setBackgroundImage:[self imageWithColor:actionWhenHighlightedBackgroundColor] forState:UIControlStateHighlighted];
}

@end
