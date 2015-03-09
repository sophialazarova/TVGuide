//
//  ScheduleTableViewController.h
//  TvGuide
//
//  Created by Admin on 3/9/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipableScheduleTableViewController : UITableViewController

@property(strong,nonatomic) UISwipeGestureRecognizer *leftSwipeRecognizer;
@property(strong,nonatomic) UISwipeGestureRecognizer *rightSwipeRecognizer;

@end
