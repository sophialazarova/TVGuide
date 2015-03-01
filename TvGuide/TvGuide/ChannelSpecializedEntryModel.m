//
//  ChannelSpecializedEntryModel.m
//  TvGuide
//
//  Created by Admin on 2/27/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "ChannelSpecializedEntryModel.h"

@implementation ChannelSpecializedEntryModel

-(instancetype)initWithChannelName:(NSString *)name entries:(NSArray *)entries{
    self = [super init];
    if (self){
        self.channelName = name;
        self.channelEntries = entries;
    }
    
    return self;
}
@end
