//
//  ChannelScheduleEntry.m
//  TvGuide
//
//  Created by Admin on 1/4/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "ChannelScheduleEntryModel.h"

@implementation ChannelScheduleEntryModel

-(id)initWithTitle:(NSString *)title andTime:(NSString *)time{
    self = [super init];
    if(self){
        self.title = title;
        self.time = time;
    }
    
    return self;
}

@end
