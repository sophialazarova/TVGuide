//
//  ChannelScheduleEntry.h
//  TvGuide
//
//  Created by Admin on 1/4/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelScheduleEntryModel : NSObject

-(id) initWithTitle:(NSString*) title andTime:(NSString*) time;

@property(strong,nonatomic) NSString *title;

@property(strong,nonatomic) NSString *time;

@end
