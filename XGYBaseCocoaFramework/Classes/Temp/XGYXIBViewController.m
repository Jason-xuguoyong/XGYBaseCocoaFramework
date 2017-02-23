//
//  XGYXIBViewController.m
//  XGYEvaluationRCode
//
//  Created by Jason on 2017/2/22.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "XGYXIBViewController.h"
#import "TExtTableViewCell.h"
@interface XGYXIBViewController ()

@end

@implementation XGYXIBViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    TExtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TExtTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        
    }
    cell.textBlock = ^(id data)
    {
    
        NSLog(@"%ld ==========",indexPath.row);
    };
    

    
    return cell;
}


@end
