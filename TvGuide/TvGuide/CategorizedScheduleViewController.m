//
//  CategorizedScheduleViewController.m
//  TvGuide
//
//  Created by Admin on 3/1/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "CategorizedScheduleViewController.h"
#import "CategorizedSchedulesView.h"
#import "CategorizedSchedulesTableViewController.h"
#import "RemoteDataManager.h"

@interface CategorizedScheduleViewController ()

@end

@implementation CategorizedScheduleViewController{
    RemoteDataManager *remoteManager;
    CategorizedSchedulesView *categorizedView;
}

-(instancetype)initWithScheduleType:(CategorizedScheduleType)type{
    self = [super init];
    if(self){
        self.scheduleType = type;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    remoteManager = [[RemoteDataManager alloc] init];
    [categorizedView addAction:@selector(searchForSchedule) caller:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView{
    categorizedView = [[CategorizedSchedulesView alloc] init];
    self.view = categorizedView;
}

-(NSString*) transformDate:(NSDate*) date{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [NSString stringWithFormat:@"%@",[outputFormatter stringFromDate:date]];
    return dateTime;
}

- (void)searchForSchedule{
    
    NSString *date = [self transformDate:[categorizedView.datePicker date]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray * result = [remoteManager getCategorizedSchedule:self.scheduleType date:date];
        dispatch_async(dispatch_get_main_queue(), ^{
            CategorizedSchedulesTableViewController *next = [[CategorizedSchedulesTableViewController alloc] init];
            next.data = result;
            [[self navigationController] pushViewController:next animated:YES];
        });
    });
}


@end
