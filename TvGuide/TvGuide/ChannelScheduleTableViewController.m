//
//  ChannelScheduleTableViewController.m
//  TvGuide
//
//  Created by Admin on 1/4/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "ChannelScheduleTableViewController.h"
#import "ChannelScheduleItemTableViewCell.h"
#import "ChannelScheduleEntryModel.h"
#import "UIColor+VeplayCommon.h"

@interface ChannelScheduleTableViewController ()

@end

@implementation ChannelScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.header;
        [self.tableView registerClass:[ChannelScheduleItemTableViewCell class] forCellReuseIdentifier:@"channelScheduleItem"];
    
    self.tableView.estimatedRowHeight = 90.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.schedule count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChannelScheduleItemTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"channelScheduleItem" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[ChannelScheduleItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"channelScheduleItem"];
    }
    
    ChannelScheduleEntryModel *entry = [self.schedule objectAtIndex:indexPath.row];
    cell.title.text = entry.title;
    cell.time.text = entry.time;
    
    [cell setNeedsDisplay];
    [cell layoutIfNeeded];
    
    return cell;
}

@end
