//
//  Utility.m
//  TvGuide
//
//  Created by Admin on 3/2/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(void) changeBackgroundUserInteractionTo:(BOOL) isInteractionEnabled backgroundViews:(NSArray*) views{
    for (int i = 0; i < views.count; i++) {
        UIView *current = [views objectAtIndex:i];
        current.userInteractionEnabled = isInteractionEnabled;
    }
}

+(void) limitDatePicker:(UIDatePicker*) datePicker{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    [comps setDay:5];
    NSDate *maxDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
}


@end
