//
//  SchedulesDataSource.h
//  TvGuide
//
//  Created by Sophiya Lazarova on 11/3/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchedulesDataSource : UITableViewController

@property(strong, nonatomic) NSArray *data;

@property(assign, nonatomic) BOOL isLoaded;

@end
