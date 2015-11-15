//
//  LoadingChannelHelper.m
//  TvGuide
//
//  Created by Admin on 1/14/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "LoadingChannelHelper.h"
#import "Channel.h"
#import "CoreDataManager.h"

@implementation LoadingChannelHelper
{
    CoreDataManager *_coredataManager;
}

-(instancetype)init
{
    self = [super init];
    if(self){
        _coredataManager = [CoreDataManager getManager];
    }
    
    return self;
}

-(void)loadChannels
{
    NSArray* channels = [self loadChannelsFromFile];
    [self saveChannelsToDatabase:channels];
}

-(NSArray*) loadChannelsFromFile
{
    NSString *channelsListPath = [[NSBundle mainBundle] pathForResource:@"ListOfChannels" ofType:@"plist"];
    NSArray * channelsList = [NSArray arrayWithContentsOfFile:channelsListPath];
    return channelsList;
}

-(void) saveChannelsToDatabase:(NSArray*) channels
{
    for (int i = 0; i< [channels count]; i++) {
        NSDictionary *dict = [channels objectAtIndex:i];
        Channel *currentChannel = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:_coredataManager.context];
        currentChannel.name = [dict valueForKey:@"name"];
       currentChannel.code = [dict valueForKey:@"code"];
        [_coredataManager.context insertObject:currentChannel];
    }
    
    [_coredataManager saveContext];
}

@end
