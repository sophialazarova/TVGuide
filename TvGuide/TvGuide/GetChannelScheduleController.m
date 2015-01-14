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

@interface GetChannelScheduleController ()

@end

@implementation GetChannelScheduleController{
    RemoteDataManager *remoteManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    remoteManager = [[RemoteDataManager alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray * result = [remoteManager getScheduleForChannel:11 WithDate:@"2015-01-04"];
        dispatch_async(dispatch_get_main_queue(), ^{
            ChannelScheduleTableViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"channelSchedule"];
            next.schedule = result;
            next.header = [NSString stringWithFormat:@"%@\n%@",@"BNT",@"01-04-2015"];
            [[self navigationController] pushViewController:next animated:YES];
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
