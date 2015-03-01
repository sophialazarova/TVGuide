//
//  CategorizedSchedulesTableViewController.m
//  TvGuide
//
//  Created by Admin on 3/1/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "CategorizedSchedulesTableViewController.h"
#import "RemoteDataManager.h"
#import "ChannelSpecializedEntryModel.h"
#import "ChannelScheduleItemTableViewCell.h"
#import "UIColor+VeplayCommon.h"

@interface CategorizedSchedulesTableViewController ()

@end

@implementation CategorizedSchedulesTableViewController{
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ChannelScheduleItemTableViewCell class] forCellReuseIdentifier:@"categorizedCell"];
    
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
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ChannelSpecializedEntryModel *current = [self.data objectAtIndex:section];
    NSInteger *count = current.channelEntries.count;
    return current.channelEntries.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     ChannelSpecializedEntryModel *current = [self.data objectAtIndex:section];
    NSString *sectionTitle = current.channelName;
    return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannelScheduleItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categorizedCell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[ChannelScheduleItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categorizedCell"];
    }
    
    ChannelSpecializedEntryModel *currentTV = [self.data objectAtIndex:indexPath.section];
    NSArray *entries = currentTV.channelEntries;
    NSInteger rows = [self.tableView numberOfRowsInSection:indexPath.section];
    NSInteger r = indexPath.row;
    if(indexPath.row >= rows){
        cell.time.text = [[entries objectAtIndex:indexPath.row - (indexPath.row-rows) - 1] time];
        cell.title.text = [[entries objectAtIndex:indexPath.row - (indexPath.row-rows) - 1] title];
    }
    else{
        cell.time.text = [[entries objectAtIndex:indexPath.row] time];
        cell.title.text = [[entries objectAtIndex:indexPath.row] title];
    }
    NSInteger imd = indexPath.row - (indexPath.row-rows);
    
    
    [cell setNeedsDisplay];
    [cell layoutIfNeeded];
    
    return cell;
}



@end
