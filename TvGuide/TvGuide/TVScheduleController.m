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
    UITabBarController *cont = [self createTabController];
    [self.navigationController pushViewController:cont animated:YES];
    
    NSInteger selectedIndex = [view.channelPicker selectedRowInComponent:0];
    NSString* channelName = [channelsList objectAtIndex:selectedIndex];
    cont.navigationItem.title = channelName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITabBarController*) createTabController{
    UITabBarController *tabBar = [[UITabBarController alloc] init];
 
    NSArray *controllersArray = [self initializeTabBarControllers];
    tabBar.viewControllers = controllersArray;
    
    return tabBar;
}


-(NSArray*) initializeTabBarControllers{
    NSDate *current = [NSDate date];
    NSDate *tomorrowDate = [self addDays:1 ToDate:current];
    NSDate *thirdDate = [self addDays:2 ToDate:current];
    NSDate *fourthDate = [self addDays:3 ToDate:current];
    NSDate *fifthDate = [self addDays:4 ToDate:current];
    
    NSInteger selectedIndex = [view.channelPicker selectedRowInComponent:0];
    NSString* channelName = [channelsList objectAtIndex:selectedIndex];
    
    ChannelScheduleTableViewController *today = [[ChannelScheduleTableViewController alloc] initWithChannelName:channelName SearchDate:current];
    ChannelScheduleTableViewController *tomorrow = [[ChannelScheduleTableViewController alloc] initWithChannelName:channelName SearchDate:tomorrowDate];
    ChannelScheduleTableViewController *thirdDay = [[ChannelScheduleTableViewController alloc] initWithChannelName:channelName SearchDate:thirdDate];
    ChannelScheduleTableViewController *fourthDay = [[ChannelScheduleTableViewController alloc] initWithChannelName:channelName SearchDate:fourthDate];
    ChannelScheduleTableViewController *fifthDay = [[ChannelScheduleTableViewController alloc] initWithChannelName:channelName SearchDate:fifthDate];
    
    [self attachTabBarItemWithName:@"Днес" ToController:today];
    [self attachTabBarItemWithName:@"Утре" ToController:tomorrow];
    [self attachTabBarItemWithName:[Utility transformDate:thirdDate] ToController:thirdDay];
    [self attachTabBarItemWithName:[Utility transformDate:fourthDate] ToController:fourthDay];
    [self attachTabBarItemWithName:[Utility transformDate:fifthDate] ToController:fifthDay];
    
    NSArray *controllersArray = [NSArray arrayWithObjects:today,tomorrow,thirdDay,fourthDay,fifthDay, nil];
    return controllersArray;
}

-(NSDate*) addDays:(NSInteger) days ToDate:(NSDate*) date{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    NSDate *result = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    return result;
}

-(void) attachTabBarItemWithName:(NSString*) name ToController:(UIViewController*) contr{
    UITabBarItem* tabBar = [[UITabBarItem alloc] initWithTitle:name image:[UIImage imageNamed:@"circle.png"] tag:0];
    tabBar.selectedImage = [UIImage imageNamed:@"checkmark-small.png"];
    contr.tabBarItem = tabBar;
}

@end
