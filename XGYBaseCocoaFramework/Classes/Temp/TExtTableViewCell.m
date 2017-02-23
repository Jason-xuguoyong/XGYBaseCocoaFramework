//
//  TExtTableViewCell.m
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/22.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "TExtTableViewCell.h"
@implementation TExtTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    self.accessoryView = textField;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
}

@end
