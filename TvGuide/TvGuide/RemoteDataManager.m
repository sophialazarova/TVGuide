//
//  RemoteDataManager.m
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "RemoteDataManager.h"
#import "ChannelScheduleEntry.h"
#import "ChannelSpecializedEntryModel.h"
#import "TVShowEntryModel.h"
#import "CategorizedScheduleType.h"

@implementation RemoteDataManager

-(NSMutableArray*)getScheduleForChannel:(NSString*)channel WithDate:(NSString *)date{
    NSURL *url = [[NSURL alloc] initWithString:
                  [NSString stringWithFormat:
                   @"http://tvguide-2.apphb.com/api/tvguide/GetScheduleForChannel?channel=%@&date=%@",
                   channel,date]];
    NSMutableArray *scheduleItems = [[NSMutableArray alloc] init];
    NSError *error = nil;
    NSData *data = [self getDataRequestForUrl:url error:error];
    if(data.length>0 && error == nil){
        scheduleItems = [self serializeChannelScheduleData:data];
    }
    else{
        //handle server returning error!
    }

    return scheduleItems;
}

-(NSMutableArray*) getCategorizedSchedule:(CategorizedScheduleType) scheduleType date:(NSString*) date{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if(scheduleType == CategorizedScheduleTypeMovies){
        NSString *url = @"http://tvguide-2.apphb.com/api/tvguide/GetMoviesSchedule";
        result = [self getCategorizedScheduleForDate:date url:url];

    }
    else if (scheduleType == CategorizedScheduleTypeSports){
        NSString *url = @"http://tvguide-2.apphb.com/api/tvguide/GetSportsSchedule";
        result = [self getCategorizedScheduleForDate:date url:url];

    }
    else{
        NSString *url = @"http://tvguide-2.apphb.com/api/tvguide/GetTVSeriesSchedule";
        result = [self getCategorizedScheduleForDate:date url:url];
    }
    
    return result;
}

/*-(NSMutableArray*)getSeriesScheduleForDate:(NSString *)date{
    NSString *url = @"http://tvguide-2.apphb.com/api/tvguide/GetTVSeriesSchedule";
    return [self getCategorizedScheduleForDate:date url:url];
}

-(NSMutableArray*)getMoviesScheduleForDate:(NSString *)date{
    NSString *url = @"http://tvguide-2.apphb.com/api/tvguide/GetMoviesSchedule";
    return [self getCategorizedScheduleForDate:date url:url];
}

-(NSMutableArray*)getSportsScheduleForDate:(NSString *)date{
    NSString *url = @"http://tvguide-2.apphb.com/api/tvguide/GetSportsSchedule";
    return [self getCategorizedScheduleForDate:date url:url];
}*/

-(NSMutableArray*) getCategorizedScheduleForDate:(NSString*) date url:(NSString*) initialUrl{
    NSURL *url = [[NSURL alloc] initWithString:
                  [NSString stringWithFormat:
                   @"%@?date=%@",initialUrl,date]];
    
    NSMutableArray *series = [[NSMutableArray alloc] init];
    NSError *error = nil;
    NSData *data = [self getDataRequestForUrl:url error:error];
    if(data.length>0 && error == nil){
        series = [self serializeSpecializedSchedule:data];
    }
    else{
        //handle server returning error!
    }
    
    return series;
}



-(NSData*) getDataRequestForUrl:(NSURL*) url error:(NSError*) error{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return data;
}

-(NSMutableArray*) serializeChannelScheduleData:(NSData*) data{
    NSError *error = nil;
    NSMutableArray *scheduleItems = [[NSMutableArray alloc] init];
    NSArray *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

    for (int i = 0; i<responseData.count; i++) {
        NSDictionary *item = [responseData objectAtIndex:i];
        NSString *name = [item objectForKey:@"Name"];
        NSString *time = [item objectForKey:@"Time"];
        ChannelScheduleEntry *currentEntry = [[ChannelScheduleEntry alloc] initWithTitle:name andTime:time];
        [scheduleItems addObject:currentEntry];
    }
    
    return scheduleItems;
}

-(NSMutableArray*) serializeSpecializedSchedule:(NSData*) data{
    NSError *error = nil;
    NSMutableArray *seriesItems = [[NSMutableArray alloc] init];
    NSArray *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

    for (int i = 0; i<responseData.count; i++) {
        NSDictionary *item = [responseData objectAtIndex:i];
        NSString *name = [item objectForKey:@"NameOfTV"];
        NSArray *series = [item objectForKey:@"Series"];
        NSArray *seriesAsObjects = [self serializeTVShowCollection:series];
        ChannelSpecializedEntryModel *currentItem = [[ChannelSpecializedEntryModel alloc] initWithChannelName:name entries:seriesAsObjects];
        [seriesItems addObject:currentItem];
    }
    
    return seriesItems;
}

-(NSArray*) serializeTVShowCollection:(NSArray*) entries{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < entries.count; i++) {
        NSDictionary *item = [entries objectAtIndex:i];
        NSString *title =  [item objectForKey:@"Name"];
        NSString *time = [item objectForKey:@"Time"];
        NSString *day = [item objectForKey:@"Day"];
        TvShowEntryModel *current = [[TvShowEntryModel alloc] initWithTitle:title time:time day:day];
        [result addObject:current];
    }
    
    return result;
}

@end
