//
//  CategorizedSchedulesTableViewController.h
//  TvGuide
//
//  Created by Admin on 3/1/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategorizedScheduleType.h"
#import "SwipableScheduleTableViewController.h"

@interface CategorizedSchedulesTableViewController : SwipableScheduleTableViewController

@property(strong,nonatomic) NSArray *data;
@property(strong,nonatomic) NSString *header;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;

@property(strong,nonatomic) NSDate *searchDate;
@property(assign,nonatomic) CategorizedScheduleType type;

-(instancetype) initWithType:(CategorizedScheduleType) type searchDate:(NSDate*) date;
@end
