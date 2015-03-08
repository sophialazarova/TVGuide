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

+(void) changeBackgroundUserInteractionTo:(BOOL) isInteractionEnabled backgroundViews:(NSArray*) views;

+(void) limitDatePicker:(UIDatePicker*) datePicker;

+(NSString*) transformDate:(NSDate*) date;

@end
