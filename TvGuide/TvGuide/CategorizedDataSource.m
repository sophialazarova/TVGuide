//
//  CategorizedDataSource.m
//  TvGuide
//
//  Created by Sophia on 11/12/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import "CategorizedDataSource.h"
#import "CategorizedEntryModel.h"
#import "ChannelScheduleItemTableViewCell.h"
#import "TvShowEntryModel.h"
#import "UIColor+HexRepresentation.h"

@implementation CategorizedDataSource

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[ChannelScheduleItemTableViewCell class] forCellReuseIdentifier:@"categorizedCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"header"];
    self.data = [NSArray new];
    self.tableView.backgroundColor = [UIColor colorWithHexValue:@"FDF9E2" alpha:1.0];
    _isLoaded = NO;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelScheduleItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categorizedCell" forIndexPath:indexPath];
    
    CategorizedEntryModel *currentTV = [self.data objectAtIndex:indexPath.section];
    NSArray *entries = currentTV.channelEntries;
    NSInteger rows = [self.tableView numberOfRowsInSection:indexPath.section];
    
    if(indexPath.row >= rows){
        TvShowEntryModel *currentShow = [entries objectAtIndex:indexPath.row - (indexPath.row-rows) - 1];
        cell.time.text = currentShow.time;
        cell.title.text = currentShow.title;
    }
    else{
        TvShowEntryModel *currentShow = [entries objectAtIndex:indexPath.row];
        cell.time.text = currentShow.time;
        cell.title.text = currentShow.title;
    }
    
    [cell setNeedsDisplay];
    [cell layoutIfNeeded];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CategorizedEntryModel *current = [self.data objectAtIndex:section];
    return current.channelEntries.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CategorizedEntryModel *current = [self.data objectAtIndex:section];
    NSString *sectionTitle = current.channelName;
    return sectionTitle;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
    cell.backgroundColor = [UIColor colorWithHexValue:@"000000" alpha:0.2];
    cell.textLabel.text = [self.data[section] channelName];
    return cell;
}

@end
