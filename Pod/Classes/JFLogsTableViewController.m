//
//  JFLogsScreenViewController.m
//  JiffyLogger
//
//  Created by Julietta Yaunches on 9/11/15.
//  Copyright © 2015 jyaunches. All rights reserved.
//

#import <JiffyLogger/JFLoggingActionManager.h>
#import "JFLogsTableViewController.h"
#import "JFLogTableViewCell.h"
#import "JFExpandableLabel.h"
#import "JFFileLogger.h"

NSString *LOG_TABLE_VIEW_CELL = @"LOG_TABLE_VIEW_CELL";

@interface JFLogsTableViewController ()
@property(nonatomic, strong) NSArray *logs;
@property(nonatomic, strong) JFFileLogger *logger;
@property(nonatomic, strong) id actionSheetManager;
@end

@implementation JFLogsTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.logger writeQueued];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action)];
    [self.tableView registerClass:[JFLogTableViewCell class] forCellReuseIdentifier:LOG_TABLE_VIEW_CELL];
    self.logs = [self.logger allLogs];
}

- (id)initWithLogger:(JFFileLogger *)logger {
    self = [super init];
    self.logger = logger;
    [self.logger writeQueued];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LOG_TABLE_VIEW_CELL forIndexPath:indexPath];
    NSString *log = self.logs[indexPath.row];

    [cell setup:log];
    return cell;
}

- (void)action {
    self.actionSheetManager = [[JFLoggingActionManager alloc] initWithSource:self andLogger:self.logger onTruncate:^(){
        [self reloadData];
    }];
    [self.actionSheetManager show];
}

- (void)reloadData {
    [self.logger writeQueued];
    self.logs = [self.logger latestLogs];
    [self.tableView reloadData];
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
