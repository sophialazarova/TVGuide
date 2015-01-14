//
//  ViewController.m
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "GetChannelScheduleController.h"
#import "RemoteDataManager.h"
#import "ChannelScheduleTableViewController.h"
#import "LoadingChannelHelper.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "Channel.h"

@interface GetChannelScheduleController ()

@end

@implementation GetChannelScheduleController{
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
    
    remoteManager = [[RemoteDataManager alloc] init];
    coredataManager = [CoreDataManager getManager];
    [self attachPickerToTextField:self.channel :self.channelPicker];
    now = [self getCurrentDate];
}

-(NSString*) getCurrentDate{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [NSString stringWithFormat:@"%@",[outputFormatter stringFromDate:[NSDate date]]];
    return dateTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)attachPickerToTextField: (UITextField*) textField :(UIPickerView*) picker{
    picker.delegate = self;
    picker.dataSource = self;
    textField.inputView = picker;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [channelsList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [channelsList objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.channel.text = [channelsList objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.channel resignFirstResponder];
}


- (IBAction)searchForSchedule:(UIButton *)sender {
    NSString* channelName = self.channel.text;
    NSFetchRequest *requestForCode = [[NSFetchRequest alloc] initWithEntityName:@"Channel"];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name == %@", channelName];
    [requestForCode setPredicate:filter];
    NSError *error = nil;
    NSArray* searchedChannelEntry = [coredataManager.context executeFetchRequest:requestForCode error:&error];
    Channel *current = [searchedChannelEntry objectAtIndex:0];
    searchedChannelCode = current.code;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     NSArray * result = [remoteManager getScheduleForChannel:searchedChannelCode WithDate:now];
     dispatch_async(dispatch_get_main_queue(), ^{
     ChannelScheduleTableViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"channelSchedule"];
     next.schedule = result;
     next.header = [NSString stringWithFormat:@"%@\n%@",current.name,now];
     [[self navigationController] pushViewController:next animated:YES];
     });
});
}

@end
