//
//  Channel.h
//  TvGuide
//
//  Created by Admin on 1/14/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Channel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * code;

@end
