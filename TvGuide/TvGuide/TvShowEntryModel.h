//
//  TvShowEntryModel.h
//  TvGuide
//
//  Created by Admin on 2/27/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TvShowEntryModel : NSObject

-(instancetype) initWithTitle:(NSString*) title time:(NSString*) time day:(NSString*) day;

@property(strong, nonatomic) NSString *title;

@property(strong,nonatomic) NSString *time;

@property(strong,nonatomic) NSString *day;

@end
