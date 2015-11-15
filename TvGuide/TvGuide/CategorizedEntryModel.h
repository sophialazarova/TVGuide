//
//  CategorizedEntryModel.h
//  TvGuide
//
//  Created by Admin on 2/27/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategorizedEntryModel : NSObject

-(instancetype) initWithChannelName:(NSString*) name entries:(NSArray*) entries;

@property(strong,nonatomic) NSString *channelName;

@property(strong, nonatomic) NSArray *channelEntries;

@end
