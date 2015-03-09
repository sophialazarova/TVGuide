//
//  Utility.h
//  TvGuide
//
//  Created by Admin on 3/2/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

+(NSString*) transformDate:(NSDate*) date;

+(NSDate*) addDays:(NSInteger) days ToDate:(NSDate*) date;

@end
