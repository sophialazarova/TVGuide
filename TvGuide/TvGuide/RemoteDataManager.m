//
//  RemoteDataManager.m
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "RemoteDataManager.h"

#import "ChannelScheduleEntry.h"

@implementation RemoteDataManager

-(NSMutableArray*)getScheduleForChannel:(NSString*)channel WithDate:(NSString *)date{
    NSURL *url = [[NSURL alloc] initWithString:
                  [NSString stringWithFormat:
                   @"http://tvguide-2.apphb.com/api/tvguide/GetScheduleForChannel?channel=%@&date=%@",
                   channel,date]];
    NSMutableArray *scheduleItems = [[NSMutableArray alloc] init];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(data.length>0 && error == nil){
        
        NSArray *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        for (int i = 0; i<responseData.count; i++) {
            NSDictionary *item = [responseData objectAtIndex:i];
            NSString *name = [item objectForKey:@"Name"];
            NSString *time = [item objectForKey:@"Time"];
            ChannelScheduleEntry *currentEntry = [[ChannelScheduleEntry alloc] initWithTitle:name andTime:time];
            [scheduleItems addObject:currentEntry];
        }
    }
    else{
        //handle server returning error!
    }

    return scheduleItems;
}

-(void)getSeriesScheduleForDate:(NSString *)date{
    
}
@end
