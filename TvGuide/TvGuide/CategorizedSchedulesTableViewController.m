//
//  CategorizedSchedulesTableViewController.m
//  TvGuide
//
//  Created by Admin on 3/1/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "CategorizedSchedulesTableViewController.h"
#import "RemoteDataManager.h"
#import "ChannelSpecializedEntryModel.h"
#import "ChannelScheduleItemTableViewCell.h"
#import "UIColor+VeplayCommon.h"
#import "TvShowEntryModel.h"
#import "RemoteDataManager.h"
#import "Masonry.h"
#import "CategorizedScheduleType.h"
#import "Utility.h"


@interface CategorizedSchedulesTableViewController ()

@end

@implementation CategorizedSchedulesTableViewController{
    RemoteDataManager *remoteManager;
}

-(instancetype)initWithType:(CategorizedScheduleType)type searchDate:(NSDate *)date{
    self = [super init];
    if(self){
        self.searchDate = date;
        self.type = type;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ChannelScheduleItemTableViewCell class] forCellReuseIdentifier:@"categorizedCell"];
    
    self.tableView.estimatedRowHeight = 90.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    
    remoteManager = [[RemoteDataManager alloc] init];
    
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
    [self searchForScheduleForDate:self.searchDate scheduleType:self.type];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ChannelSpecializedEntryModel *current = [self.data objectAtIndex:section];
    return current.channelEntries.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     ChannelSpecializedEntryModel *current = [self.data objectAtIndex:section];
    NSString *sectionTitle = current.channelName;
    return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannelScheduleItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categorizedCell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[ChannelScheduleItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categorizedCell"];
    }
    
    ChannelSpecializedEntryModel *currentTV = [self.data objectAtIndex:indexPath.section];
    NSArray *entries = currentTV.channelEntries;
    NSInteger rows = [self.tableView numberOfRowsInSection:indexPath.section];
    
    //////FIX ME (THE if BELOW)////
    
    
    if(indexPath.row >= rows){
        TvShowEntryModel *currentShow = [entries objectAtIndex:indexPath.row - (indexPath.row-rows) - 1];
        cell.time.text = currentShow.time;
        cell.title.text = currentShow.title;
    }
    else{
        TvShowEntryModel *currentShow = [entries objectAtIndex:indexPath.row];
        cell.time.text = currentShow.time;
        cell.title.text = currentShow.title;
    }

    [cell setNeedsDisplay];
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)searchForScheduleForDate:(NSDate*) searchDate scheduleType:(CategorizedScheduleType) type{
    NSString *date = [Utility transformDate:searchDate];
    [self.activityIndicator startAnimating];
    self.tableView.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray * result = [remoteManager getCategorizedSchedule:type date:date];
        dispatch_async(dispatch_get_main_queue(),^{
            self.data = result;
            [self.activityIndicator stopAnimating];
            [self.tableView reloadData];
            self.tableView.userInteractionEnabled = YES;

        });
    });
}



@end
