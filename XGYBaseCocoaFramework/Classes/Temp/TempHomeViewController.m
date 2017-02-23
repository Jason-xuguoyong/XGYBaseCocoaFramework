//
//  TempHomeViewController.m
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "TempHomeViewController.h"
#import "XGYXIBViewController.h"
#import "XGYMenueView.h"
@interface TempHomeViewController ()

@end

@implementation TempHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XGYRandomColor;

    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XGYXIBViewController *xib = [[XGYXIBViewController alloc] init];
    [self.navigationController pushViewController:xib animated:YES];
    

}

@end
