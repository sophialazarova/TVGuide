//
//  ViewController.m
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "TVScheduleController.h"
#import "RemoteDataManager.h"
#import "ChannelScheduleTableViewController.h"
#import "LoadingChannelHelper.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "Channel.h"
#import "TVScheduleView.h"
#import "Utility.h"
#import "TabBarCreationHelper.h"
#import "SchedulesViewController.h"
#import "UIColor+VeplayCommon.h"
@interface TVScheduleController ()

@end

@implementation TVScheduleController{
    RemoteDataManager *remoteManager;
    CoreDataManager *coredataManager;
    NSArray *channelsList;
    NSString *searchedChannelCode;
    NSString *now;
    TVScheduleView *view;
}

-(void)viewWillAppear:(BOOL)animated{
    channelsList = [self getChannelsList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ТВ Програма";
    self.tableView.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    remoteManager = [[RemoteDataManager alloc] init];
    coredataManager = [CoreDataManager getManager];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(NSString*) transformDate:(NSDate*) date{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [NSString stringWithFormat:@"%@",[outputFormatter stringFromDate:date]];
    return dateTime;
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
    cell.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return channelsList.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchedulesViewController *ctr = [[SchedulesViewController alloc]  init];
    ctr.channelName = channelsList[indexPath.row];
    [self.navigationController pushViewController:ctr animated:YES];
}

-(UITabBarController*) initializeTabController{
    TabBarCreationHelper *helper = [[TabBarCreationHelper alloc] init];
    NSArray *controllers = [self createTabBarControllers];
    UITabBarController *tabbar = [helper createTabControllerWithControllers:controllers];
    return tabbar;
}

-(NSArray*) createTabBarControllers{
    NSDate *today = [NSDate date];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i<5; i++) {
        ChannelScheduleTableViewController *contr = [[ChannelScheduleTableViewController alloc] initWithChannelName:[self getNameOfChosenChannel] SearchDate:[Utility addDays:i ToDate:today]];
        [result addObject:contr];
    }
    
    return result;
}

-(NSString*) getNameOfChosenChannel{
    NSInteger selectedIndex = [view.channelPicker selectedRowInComponent:0];
    NSString* channelName = [channelsList objectAtIndex:selectedIndex];
    return channelName;
}

@end
