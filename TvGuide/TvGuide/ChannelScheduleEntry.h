//
//  ChannelScheduleEntry.h
//  TvGuide
//
//  Created by Admin on 1/4/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelScheduleEntry : NSObject

@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *time;

-(id) initWithTitle:(NSString*) title andTime:(NSString*) time;

@end
