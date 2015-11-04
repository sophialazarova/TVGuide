//
//  SchedulesViewController.m
//  TvGuide
//
//  Created by Sophiya Lazarova on 11/3/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import "SchedulesViewController.h"
#import "SchedulesDataSource.h"
#import "CoreDataManager.h"
#import "RemoteDataManager.h"
#import "Channel.h"
#import "Utility.h"
#import "UIColor+VeplayCommon.h"

@implementation SchedulesViewController
{
    NSMutableArray *_schedules;
    NSMutableArray *_dataSources;
    RemoteDataManager *remoteManager;
    CoreDataManager *coredataManager;
    NSDate *_startdate;
    CGPoint lastScrollPosition;
    NSArray *colors;
}

-(instancetype)initWithChannelName:(NSString*) channelName
{
    self = [super init];
    if (self) {
        self.channelName = channelName;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    remoteManager = [[RemoteDataManager alloc] init];
    coredataManager = [CoreDataManager getManager];
    self.navigationController.navigationBar.translucent = YES;
    self.scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.scrollView.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*5, self.view.bounds.size.height);
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    _schedules = [NSMutableArray new];
    _dataSources = [NSMutableArray new];
    _startdate = [NSDate new];
    [self inittializeSchedulesAndDataSources];
    [self loadSchedulForIndex:0 ForDate:[NSDate new]];
    [self addToolbar];
}

-(void)addToolbar
{

    UIBarButtonItem *todayBtn = [self createToolbarButtonWithName:@"Днес"];
    UIBarButtonItem *tommorowBtn = [self createToolbarButtonWithName:@"Утре"];
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithObjects:todayBtn,tommorowBtn, nil];
    
    for (int i = 0; i < 5; i++) {
        NSDate *date = [Utility addDays:i ToDate:[NSDate new]];
        UIBarButtonItem *button = [self createToolbarButtonWithName:[self transformDate:date]];
        [buttons addObject:button];
    }

    NSArray *toolbarItems = buttons;
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    toolbar.backgroundColor = [UIColor yellowColor];
   [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0]} forState:UIControlStateNormal];
    [self.view addSubview:toolbar];
    [toolbar setItems:toolbarItems];
}

-(void) inittializeSchedulesAndDataSources
{
    for (int i = 0; i < 5; i++) {
        SchedulesDataSource *ctr = [SchedulesDataSource new];
        ctr.view.backgroundColor = colors[i];
        ctr.view.frame = CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height);
        [_schedules addObject:ctr];
        [self addChildViewController:ctr];
        [self.scrollView addSubview:ctr.view];
    }
}

-(NSString*) getChannelCode:(NSString*) channelName{
    NSFetchRequest *requestForCode = [[NSFetchRequest alloc] initWithEntityName:@"Channel"];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name == %@", channelName];
    [requestForCode setPredicate:filter];
    NSError *error = nil;
    NSArray* searchedChannelEntry = [coredataManager.context executeFetchRequest:requestForCode error:&error];
    Channel *current = [searchedChannelEntry objectAtIndex:0];
    NSString *result = current.code;
    return result;
}

- (void)loadSchedulForIndex:(NSInteger) index ForDate:(NSDate*) searchDate{
    NSString* searchedChannelCode = [self getChannelCode:self.channelName];
    NSString *date = [Utility transformDate:searchDate];
    SchedulesDataSource *table = _schedules[index];
    if (table.isLoaded) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       NSArray *result = [remoteManager getScheduleForChannel:searchedChannelCode WithDate:date];
        int a = 5;
        dispatch_async(dispatch_get_main_queue(),^{
            SchedulesDataSource *currentTable = _schedules[index];
            currentTable.data = result;
            [currentTable.tableView reloadData];
        });

    });
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
        NSDate *today = [NSDate new];
        CGPoint scrollPoint = scrollView.contentOffset;
        if (scrollPoint.x < self.view.bounds.size.width) {
            [self loadSchedulForIndex:0 ForDate:today];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width && scrollPoint.x < self.view.bounds.size.width*2) {
            [self loadSchedulForIndex:1 ForDate:[Utility addDays:1 ToDate:today]];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width*2 && scrollPoint.x < self.view.bounds.size.width*3) {
            [self loadSchedulForIndex:2 ForDate:[Utility addDays:2 ToDate:today]];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width*3 && scrollPoint.x < self.view.bounds.size.width*4) {
            [self loadSchedulForIndex:3 ForDate:[Utility addDays:3 ToDate:today]];
        }
        else {
            [self loadSchedulForIndex:4 ForDate:[Utility addDays:4 ToDate:today]];
        }
}

-(NSString*) transformDate:(NSDate*) date{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [NSString stringWithFormat:@"%@",[outputFormatter stringFromDate:date]];
    return dateTime;
}

-(UIBarButtonItem*) createToolbarButtonWithName:(NSString*) name{
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:name style:UIBarButtonItemStylePlain
                               target:self action:@selector(toolBarItem1:)];

    return button;
}

@end
