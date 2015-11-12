//
//  ViewController.m
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "ChannelsTableViewController.h"
#import "RemoteDataManager.h"
#import "ChannelScheduleTableViewController.h"
#import "LoadingChannelHelper.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "Channel.h"
#import "Utility.h"
#import "SchedulesViewController.h"
#import "UIColor+HexRepresentation.h"
@interface ChannelsTableViewController ()

@end

@implementation ChannelsTableViewController{
    RemoteDataManager *remoteManager;
    CoreDataManager *coredataManager;
    NSArray *channelsList;
    NSString *searchedChannelCode;
    NSString *now;
}

-(void)viewWillAppear:(BOOL)animated{
    channelsList = [self getChannelsList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ТВ Програма";
    self.tableView.backgroundColor = [UIColor colorWithHexValue:@"FDF9E2" alpha:1.0];
    remoteManager = [[RemoteDataManager alloc] init];
    coredataManager = [CoreDataManager getManager];
 
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    self.navigationController.navigationBar.translucent = YES;
}

-(NSArray*) getChannelsList{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Channel"];
    [request setPropertiesToFetch: [NSArray arrayWithObjects:@"name", nil]];
    NSArray *fetchedObjects = [coredataManager.context executeFetchRequest:request error:nil];
    NSMutableArray *channels = [[NSMutableArray alloc] initWithCapacity:[fetchedObjects count]];
    for (int i = 0; i<[fetchedObjects count]; i++) {
        [channels addObject:[[fetchedObjects objectAtIndex:i] name]];
    }
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    [channels sortUsingDescriptors:@[sd]];
    return channels;
}

#pragma mark - TableView methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = channelsList[indexPath.row];
    cell.backgroundColor = [UIColor colorWithHexValue:@"FDF9E2" alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return channelsList.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchedulesViewController *ctr = [[SchedulesViewController alloc]  initWithChannelName:channelsList[indexPath.row]];
    ctr.navigationItem.title = channelsList[indexPath.row];
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
