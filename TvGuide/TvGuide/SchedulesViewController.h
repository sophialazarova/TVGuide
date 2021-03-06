//
//  SchedulesViewController.h
//  TvGuide
//
//  Created by Sophiya Lazarova on 11/3/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategorizedScheduleType.h"

@interface SchedulesViewController : UIViewController<UIScrollViewDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) NSString *channelName;

@property(assign, nonatomic) CategorizedScheduleType queryType;

@property(assign, nonatomic) BOOL isCategorized;

-(instancetype)initWithChannelName:(NSString*) channelName;

@end
