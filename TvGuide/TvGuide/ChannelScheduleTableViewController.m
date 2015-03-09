//
//  ChannelScheduleTableViewController.m
//  TvGuide
//
//  Created by Admin on 1/4/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "ChannelScheduleTableViewController.h"
#import "ChannelScheduleItemTableViewCell.h"
#import "ChannelScheduleEntryModel.h"
#import "UIColor+VeplayCommon.h"
#import "Utility.h"
#import "Masonry.h"
#import"RemoteDataManager.h"
#import "CoreDataManager.h"
#import "Channel.h"
#import <CoreData/CoreData.h>

@interface ChannelScheduleTableViewController ()

@end

@implementation ChannelScheduleTableViewController{
    RemoteDataManager *remoteManager;
    CoreDataManager *coredataManager;
}

-(instancetype)initWithChannelName:(NSString *)channelName SearchDate:(NSDate *)date{
    self = [super init];
    if(self){
        self.date = date;
        self.channelName = channelName;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    remoteManager = [[RemoteDataManager alloc] init];
    coredataManager = [CoreDataManager getManager];
    
    self.navigationItem.title = self.header;

    [self.tableView registerClass:[ChannelScheduleItemTableViewCell class] forCellReuseIdentifier:@"channelScheduleItem"];
    
    self.tableView.estimatedRowHeight = 90.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activityIndicator];
    
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.tableView.mas_height);
        make.width.mas_equalTo(self.tableView.mas_width);
        make.centerX.mas_equalTo(self.tableView.mas_centerX);
        make.centerY.mas_equalTo(self.tableView.mas_centerY);
    }];
    
    self.activityIndicator.backgroundColor = [UIColor colorWithHexValue:@"#fb9b46" alpha:1.0];
}

-(void)viewWillAppear:(BOOL)animated{
   [self searchForScheduleWithName:self.channelName ForDate:self.date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.schedule count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChannelScheduleItemTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"channelScheduleItem" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[ChannelScheduleItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"channelScheduleItem"];
    }
    
    ChannelScheduleEntryModel *entry = [self.schedule objectAtIndex:indexPath.row];
    cell.title.text = entry.title;
    cell.time.text = entry.time;
    
    [cell setNeedsDisplay];
    [cell layoutIfNeeded];
    
    return cell;
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

- (void)searchForScheduleWithName:(NSString*) searchedChannelName ForDate:(NSDate*) searchDate{
    NSString* searchedChannelCode = [self getChannelCode:searchedChannelName];
    
    NSString *date = [Utility transformDate:searchDate];
    [self.activityIndicator startAnimating];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray * result = [remoteManager getScheduleForChannel:searchedChannelCode WithDate:date];
        dispatch_async(dispatch_get_main_queue(), ^{
             self.schedule = result;
            [self.tableView reloadData];
            [self.activityIndicator stopAnimating];
        });
        
    });
}
@end
