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
    self.scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    self.scrollView.backgroundColor = [UIColor blueColor];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*5, self.view.bounds.size.height - 100);
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    _schedules = [NSMutableArray new];
    _dataSources = [NSMutableArray new];
    _startdate = [NSDate new];
    colors = [NSArray arrayWithObjects:[UIColor redColor],[UIColor yellowColor], [UIColor orangeColor], [UIColor greenColor], [UIColor brownColor]];
    [self inittializeSchedulesAndDataSources];
}

-(void) inittializeSchedulesAndDataSources
{
    for (int i = 0; i < 5; i++) {
        [_schedules addObject:[[UITableView alloc] initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height)]];
        [self.scrollView addSubview:_schedules[i]];
        [_schedules[i] setBackgroundColor:colors[i]];
        [_dataSources addObject:[SchedulesDataSource new]];
    }
}


//-(void) setupDataSources
//{
//    NSDate *current = _startdate;
//    for (int i = 0; i < 5; i++) {
//        [self searchForScheduleWithName:self.channelName ForDate:current];
//    }
//}

//-(void) setDataSourceObjects
//{
//    for (int i = 0; i < 5; i++) {
//       UITableView *tableView =  _schedules[i];
//        tableView = _dataSources[i];
//    }
//}

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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSArray *result = [remoteManager getScheduleForChannel:searchedChannelCode WithDate:date];
        SchedulesDataSource *currentDataSource = _dataSources[index];
        currentDataSource.data = result;
        UITableView *currentTable = _schedules[index];
        currentTable.dataSource = currentDataSource;
        [currentTable reloadData];
    });
}

#pragma mark - scroll view delegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     CGPoint currentPosition = scrollView.contentOffset;
    int c = round(currentPosition.x / 414);
    CGRect r = [_schedules[c] bounds];
    [scrollView scrollRectToVisible:r animated:YES];
    int a = 6;
}
@end
