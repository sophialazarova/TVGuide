//
//  TvShowEntryModel.m
//  TvGuide
//
//  Created by Admin on 2/27/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "TvShowEntryModel.h"

@implementation TvShowEntryModel

-(instancetype)initWithTitle:(NSString *)title time:(NSString *)time day:(NSString *)day
{
    self = [super init];
    if(self){
        self.title = title;
        self.time = time;
        self.day = day;
    }
    
    return self;
}

@end
