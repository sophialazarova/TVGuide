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
    self.navigationItem.title = @"TV Schedule";
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
    NSInteger selectedIndex = [view.channelPicker selectedRowInComponent:0];
    NSString* channelName = [channelsList objectAtIndex:selectedIndex];
    NSFetchRequest *requestForCode = [[NSFetchRequest alloc] initWithEntityName:@"Channel"];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name == %@", channelName];
    [requestForCode setPredicate:filter];
    NSError *error = nil;
    NSArray* searchedChannelEntry = [coredataManager.context executeFetchRequest:requestForCode error:&error];
    Channel *current = [searchedChannelEntry objectAtIndex:0];
    searchedChannelCode = current.code;

    NSString *date = [self transformDate:[view.datePicker date]];
    [view.activityIndicator startAnimating];
    [self changeBackgroundUserInteractionTo:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
     NSArray * result = [remoteManager getScheduleForChannel:searchedChannelCode WithDate:date];
     dispatch_async(dispatch_get_main_queue(), ^{
     ChannelScheduleTableViewController *next = [[ChannelScheduleTableViewController alloc] init];
     next.schedule = result;
     next.header = [NSString stringWithFormat:@"%@",current.name];
     [[self navigationController] pushViewController:next animated:YES];
     [view.activityIndicator stopAnimating];
     [self changeBackgroundUserInteractionTo:YES];
     });
    
});
}

-(void) changeBackgroundUserInteractionTo:(BOOL) isInteractionEnabled{
    view.getScheduleButton.userInteractionEnabled = isInteractionEnabled;
    view.datePicker.userInteractionEnabled = isInteractionEnabled;
    view.channelPicker.userInteractionEnabled = isInteractionEnabled;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
