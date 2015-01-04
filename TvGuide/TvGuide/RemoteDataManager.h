//
//  RemoteDataManager.h
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteDataManager : NSObject

-(NSMutableArray*) getScheduleForChannel:(NSInteger) channel WithDate: (NSString*) date;
-(void) getSeriesScheduleForDate:(NSString*) date;

@end
