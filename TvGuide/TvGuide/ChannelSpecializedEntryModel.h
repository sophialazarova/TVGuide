//
//  ChannelSpecializedEntryModel.h
//  TvGuide
//
//  Created by Admin on 2/27/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelSpecializedEntryModel : NSObject

@property(strong,nonatomic) NSString *channelName;
@property(strong, nonatomic) NSArray *channelEntries;

-(instancetype) initWithChannelName:(NSString*) name entries:(NSArray*) entries;

@end
