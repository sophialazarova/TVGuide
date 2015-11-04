//
//  SchedulesDataSource.h
//  TvGuide
//
//  Created by Sophiya Lazarova on 11/3/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SchedulesDataSource : NSObject <UITableViewDataSource>

@property(strong, nonatomic) NSArray *data;


@end
