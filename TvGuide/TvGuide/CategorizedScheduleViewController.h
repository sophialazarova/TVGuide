//
//  CategorizedScheduleViewController.h
//  TvGuide
//
//  Created by Admin on 3/1/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategorizedScheduleType.h"

@interface CategorizedScheduleViewController : UIViewController

@property(assign,nonatomic) CategorizedScheduleType scheduleType;
@property(strong,nonatomic) NSString* header;
@property(strong, nonatomic) NSDate *searchDate;

-(instancetype) initWithScheduleType:(CategorizedScheduleType) type searchDate:(NSDate*) searchDate;

@end
