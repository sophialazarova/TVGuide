//
//  ChannelScheduleTableViewController.h
//  TvGuide
//
//  Created by Admin on 1/4/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelScheduleTableViewController : UITableViewController

@property(strong,nonatomic) NSArray *schedule;
@property(strong, nonatomic) NSString *header;

@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;

@property(strong,nonatomic) NSDate *date;
@property(strong,nonatomic) NSString *channelName;

-(instancetype) initWithChannelName:(NSString*) channelName SearchDate:(NSDate*) date;

@end
