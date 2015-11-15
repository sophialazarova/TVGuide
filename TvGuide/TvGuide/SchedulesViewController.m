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
#import "UIColor+HexRepresentation.h"
#import "TransitionIndicatorView.h"
#import "CategorizedDataSource.h"

@implementation SchedulesViewController
{
    NSMutableArray *_schedules;
    NSMutableArray *_dataSources;
    RemoteDataManager *_remoteManager;
    CoreDataManager *_coredataManager;
    TransitionIndicatorView *_transitionView;
    UIActivityIndicatorView *_progressView;
    NSInteger _lastShownTabIndex;
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
    
    _lastShownTabIndex = 0;
    _remoteManager = [[RemoteDataManager alloc] init];
    _coredataManager = [CoreDataManager getManager];
    self.navigationController.navigationBar.translucent = YES;
    self.scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - (self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height + 50))];
    self.scrollView.backgroundColor = [UIColor colorWithHexValue:@"FDF9E2" alpha:1.0];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*5, self.view.bounds.size.height);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
    _progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _progressView.center = self.view.center;
    _progressView.frame = CGRectMake(self.view.bounds.size.width/2 - 30,self.view.bounds.size.height/2 - 30, 60, 60);
    [self.view addSubview:_progressView];
    [_progressView bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    _schedules = [NSMutableArray new];
    _dataSources = [NSMutableArray new];
    [self inittializeSchedulesAndDataSources];
    [self loadSchedulForIndex:0 ForDate:[NSDate new]];
    _transitionView = [[TransitionIndicatorView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    [self.view addSubview:_transitionView];
}

-(void) inittializeSchedulesAndDataSources
{
    for (int i = 0; i < 5; i++) {
        UITableViewController *ctr;
        if (_isCategorized){
            ctr = [CategorizedDataSource new];
        }
        else {
            ctr = [SchedulesDataSource new];
        }
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
    NSArray* searchedChannelEntry = [_coredataManager.context executeFetchRequest:requestForCode error:&error];
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
    [_progressView startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSArray *result;
        if (self.queryType == CategorizedScheduleTypeNone) {
            NSString* searchedChannelCode = [self getChannelCode:self.channelName];
            result = [_remoteManager getScheduleForChannel:searchedChannelCode WithDate:date];
        }
        else {
            result = [_remoteManager getCategorizedSchedule:self.queryType date:date];
        }

        dispatch_async(dispatch_get_main_queue(),^{
            SchedulesDataSource *currentTable = _schedules[index];
            currentTable.data = result;
            [currentTable.tableView reloadData];
            [_progressView stopAnimating];
        });

    });
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
        NSDate *today = [NSDate new];
        CGPoint scrollPoint = scrollView.contentOffset;
        if (scrollPoint.x < self.view.bounds.size.width) {
            [self showScheduleAtIndex:0 forDate:today];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width && scrollPoint.x < self.view.bounds.size.width*2) {
            [self showScheduleAtIndex:1 forDate:[Utility addDays:1 ToDate:today]];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width*2 && scrollPoint.x < self.view.bounds.size.width*3) {
            [self showScheduleAtIndex:2 forDate:[Utility addDays:2 ToDate:today]];
        }
        else if (scrollPoint.x >= self.view.bounds.size.width*3 && scrollPoint.x < self.view.bounds.size.width*4) {
            [self showScheduleAtIndex:3 forDate:[Utility addDays:3 ToDate:today]];
        }
        else {
            [self showScheduleAtIndex:4 forDate:[Utility addDays:4 ToDate:today]];
        }
}

-(void) showScheduleAtIndex:(NSInteger)index forDate:(NSDate*) date{
    if (_lastShownTabIndex == index) {
        return;
    }
    [self loadSchedulForIndex:index ForDate:date];
    [_transitionView setSelectionAtIndex:index];
    _lastShownTabIndex = index;
}

@end
