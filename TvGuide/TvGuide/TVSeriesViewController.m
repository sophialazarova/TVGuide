//
//  TVSeriesViewController.m
//  TvGuide
//
//  Created by Admin on 2/21/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "TVSeriesViewController.h"
#import "CategorizedSchedulesView.h"
#import "RemoteDataManager.h"
#import "CategorizedSchedulesTableViewController.h"

@interface TVSeriesViewController ()

@end

@implementation TVSeriesViewController{
    CategorizedSchedulesView *seriesView;
    RemoteDataManager *remoteManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    remoteManager = [[RemoteDataManager alloc] init];
    [seriesView addAction:@selector(searchForSchedule) caller:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView{
    seriesView = [[CategorizedSchedulesView alloc] init];
    self.view = seriesView;
}


-(NSString*) transformDate:(NSDate*) date{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [NSString stringWithFormat:@"%@",[outputFormatter stringFromDate:date]];
    return dateTime;
}

- (void)searchForSchedule{

    NSString *date = [self transformDate:[seriesView.datePicker date]];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray * result = [remoteManager getSeriesScheduleForDate:date];
        dispatch_async(dispatch_get_main_queue(), ^{
            CategorizedSchedulesTableViewController *next = [[CategorizedSchedulesTableViewController alloc] init];
            next.data = result;
           // next.header = [NSString stringWithFormat:@"%@\n%@",current.name,date];
            [[self navigationController] pushViewController:next animated:YES];
        });
    });
}

@end
