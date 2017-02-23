//
//  TExtTableViewCell.h
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/22.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TExtTableViewCell : UITableViewCell

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) void (^textBlock)(NSString *text);
@end
