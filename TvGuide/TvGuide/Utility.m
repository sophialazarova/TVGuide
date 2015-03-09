//
//  Utility.m
//  TvGuide
//
//  Created by Admin on 3/2/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(NSString*) transformDate:(NSDate*) date{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [NSString stringWithFormat:@"%@",[outputFormatter stringFromDate:date]];
    return dateTime;
}

+(NSDate*) addDays:(NSInteger) days ToDate:(NSDate*) date{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    NSDate *result = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    return result;
}

@end
