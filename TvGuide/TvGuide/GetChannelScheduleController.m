//
//  ViewController.m
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "GetChannelScheduleController.h"
#import "RemoteDataManager.h"

@interface GetChannelScheduleController ()

@end

@implementation GetChannelScheduleController{
    RemoteDataManager *remoteManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    remoteManager = [[RemoteDataManager alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray * result = [remoteManager getScheduleForChannel:11 WithDate:@"2015-01-04"];
        int a = 5;
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
