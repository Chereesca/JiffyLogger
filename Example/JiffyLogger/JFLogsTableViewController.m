//
//  JFLogsScreenViewController.m
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/11/15.
//  Copyright © 2015 jyaunches. All rights reserved.
//

#import "JFLogsTableViewController.h"
#import "JFLogTableViewCell.h"
#import "JFExpandableLabel.h"

NSString *LOG_TABLE_VIEW_CELL = @"LOG_TABLE_VIEW_CELL";

@interface JFLogsTableViewController ()
@property(nonatomic, strong) NSArray *logs;
@end

@implementation JFLogsTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action)];
    [self.tableView registerClass:[JFLogTableViewCell class] forCellReuseIdentifier:LOG_TABLE_VIEW_CELL];
    self.logs = @[@"mary had a little lamb.. little lamb, little lamb. every where that mary went the lamb was sure to go.", @"entry 2"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LOG_TABLE_VIEW_CELL forIndexPath:indexPath];
    NSString *log = self.logs[indexPath.row];

    [cell setup:log];
    return cell;
}

- (void)action {
    NSLog(@"action clicked");
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *log = self.logs[indexPath.row];
    if (log) {
        JFExpandableLabel *label = [[JFExpandableLabel alloc] initForLog:log];
        return label.bounds.size.height + 10;
    }
    return 0;
}

@end