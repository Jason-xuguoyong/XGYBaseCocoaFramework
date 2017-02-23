//
//  XGYMenueView.m
//  RMTiOSApp
//
//  Created by Jason on 2016/11/4.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XGYMenueView.h"

@interface XGYMenueView ()
@property (nonatomic,strong) NSArray *buttonTitleArray;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) NSString *messageTitle;
@property (nonatomic,strong) NSNumber *destructiveButtonIndex;
@end

@implementation XGYMenueView





/**
 实例化菜单栏
 
 @param title 标题
 @param buttonTitleArray 所有按钮的标题
 @param frame 坐标
 @param index 需要显示红色的按钮所在的位置
 */
- (instancetype)initWithMessageTitle:(NSString *)title buttonTitleArray:(NSArray *)buttonTitleArray Frame:(CGRect)frame destructiveButtonIndex:(NSNumber *)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        self.layer.cornerRadius = 15.0f;
        self.layer.masksToBounds = YES;
        self.buttonTitleArray = buttonTitleArray;
        self.destructiveButtonIndex = index;
        self.messageTitle = title;
        [self createUI];
    }
    return self;

}


-(void)createUI
{

    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(d_screen_width - 60, MAXFLOAT);
   CGSize placehoderSize = [self.messageTitle boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    UIView *titleView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, placehoderSize.height +20)];
    [self addSubview:titleView];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10,self.width-30, placehoderSize.height)];
    self.messageLabel.textColor = UIColorFromRGB(0x979797) ;
    self.messageLabel.font = [UIFont systemFontOfSize:13.0f];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.text = self.messageTitle;
    [titleView addSubview:self.messageLabel];
    
    UIView *lineViw = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.width, 0.5)];
    lineViw.backgroundColor = UIColorFromRGB(0xd5d5d5);
    [self addSubview:lineViw];
    self.menueTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame)+0.5, titleView.width, self.height-titleView.height) style:UITableViewStylePlain];
    
    self.menueTableView.delegate = self;
    self.menueTableView.dataSource = self;
    [self addSubview: self.menueTableView];
    self.menueTableView.backgroundColor = [UIColor clearColor];
  
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.buttonTitleArray.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        cell.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        UILabel *label = [[UILabel alloc] init];
       
        label.font = [UIFont systemFontOfSize:19.0f];
        label.backgroundColor =  [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 100;
        label.adjustsFontSizeToFitWidth = YES;
        [cell.contentView addSubview:label];
        label.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 10, 0, 10));
    }
    
     UILabel *label = [cell.contentView viewWithTag:100];
    
    if (self.destructiveButtonIndex &&  (int)indexPath.row == [self.destructiveButtonIndex intValue]) {
         label.textColor = [UIColor redColor];
    }else
    {
     label.textColor =UIColorFromRGB(0x007aff);
    }
  
    label.text = self.buttonTitleArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001f;
}
-(void)viewDidLayoutSubviews
{
    if ([self.menueTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.menueTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.menueTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.menueTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didClickButtonBlock) {
        self.didClickButtonBlock(self.buttonTitleArray[indexPath.row],(int)indexPath.row);
    }

}
@end
