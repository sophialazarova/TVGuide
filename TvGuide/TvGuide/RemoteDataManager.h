//
//  RemoteDataManager.h
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategorizedScheduleType.h"

@interface RemoteDataManager : NSObject

-(NSMutableArray*) getScheduleForChannel:(NSString*) channel WithDate: (NSString*) date;
-(NSMutableArray*) getCategorizedSchedule:(CategorizedScheduleType) scheduleType date:(NSString*) date;
//-(NSMutableArray*) getSeriesScheduleForDate:(NSString*) date;
//-(NSMutableArray*) getMoviesScheduleForDate:(NSString*) date;
//-(NSMutableArray*) getSportsScheduleForDate:(NSString*) date;

@end
