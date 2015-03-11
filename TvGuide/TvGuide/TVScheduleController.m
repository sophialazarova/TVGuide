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
    remoteManager = [[RemoteDataManager alloc] init];
    coredataManager = [CoreDataManager getManager];
    view.channelPicker.delegate = self;
    view.channelPicker.showsSelectionIndicator = YES;
    [view addAction:@selector(searchForSchedule) caller:self];
    view.channelPicker.delegate = self;
    view.channelPicker.dataSource = self;
}

-(void)loadView{
    view = [[TVScheduleView alloc] init];
    self.view = view;
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

#pragma mark - PickerView methods

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [channelsList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [channelsList objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (void)searchForSchedule{
    UITabBarController *cont = [self initializeTabController];
    [self.navigationController pushViewController:cont animated:YES];
    cont.navigationItem.title = [self getNameOfChosenChannel];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
