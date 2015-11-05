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
#import "TransitionIndicatorView.h"

@implementation SchedulesViewController
{
    NSMutableArray *_schedules;
    NSMutableArray *_dataSources;
    RemoteDataManager *remoteManager;
    CoreDataManager *coredataManager;
    NSDate *_startdate;
    CGPoint lastScrollPosition;
    NSArray *colors;
    TransitionIndicatorView *_transitionView;
}

-(instancetype)initWithChannelName:(NSString*) channelName
{
    self = [super init];
    if (self) {
        self.channelName = channelName;
        self.queryType = CategorizedScheduleTypeNone;
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
    self.scrollView.backgroundColor = [UIColor colorWithHexValue:@"FCAD5D" alpha:1.0];
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
    _transitionView = [[TransitionIndicatorView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    [self.view addSubview:_transitionView];
  //  [self addToolbar];
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
    NSString *date = [Utility transformDate:searchDate];
    SchedulesDataSource *table = _schedules[index];
    if (table.isLoaded) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSArray *result;
        if (self.queryType == CategorizedScheduleTypeNone) {
            NSString* searchedChannelCode = [self getChannelCode:self.channelName];
            result = [remoteManager getScheduleForChannel:searchedChannelCode WithDate:date];
        }
        else {
            result = [remoteManager getCategorizedSchedule:self.queryType date:date];
        }

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
            [_transitionView setSelectionAtIndex:0];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width && scrollPoint.x < self.view.bounds.size.width*2) {
            [self loadSchedulForIndex:1 ForDate:[Utility addDays:1 ToDate:today]];
            [_transitionView setSelectionAtIndex:1];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width*2 && scrollPoint.x < self.view.bounds.size.width*3) {
            [self loadSchedulForIndex:2 ForDate:[Utility addDays:2 ToDate:today]];
            [_transitionView setSelectionAtIndex:2];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width*3 && scrollPoint.x < self.view.bounds.size.width*4) {
            [self loadSchedulForIndex:3 ForDate:[Utility addDays:3 ToDate:today]];
            [_transitionView setSelectionAtIndex:3];
        }
        else {
            [self loadSchedulForIndex:4 ForDate:[Utility addDays:4 ToDate:today]];
            [_transitionView setSelectionAtIndex:4];
        }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (int i = 0; i < _schedules.count; i++) {
      UITableView *current =  [_schedules[i] tableView];
        current.scrollEnabled = NO;
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
