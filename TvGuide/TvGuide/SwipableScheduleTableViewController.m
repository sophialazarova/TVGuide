//
//  ScheduleTableViewController.m
//  TvGuide
//
//  Created by Admin on 3/9/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "SwipableScheduleTableViewController.h"

@interface SwipableScheduleTableViewController ()

@end

@implementation SwipableScheduleTableViewController

-(instancetype)init{
    self = [super init];
    if(self){
        self.leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        self.leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:self.leftSwipeRecognizer];
        
        self.rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        self.rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:self.rightSwipeRecognizer];
    }
    
    return self;
}

-(void) swipe:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        if(self.tabBarController.selectedIndex != 0){
           [self.tabBarController setSelectedIndex:self.tabBarController.selectedIndex-1];
        }
    }
    else{
        if(self.tabBarController.selectedIndex != self.tabBarController.viewControllers.count-1){
            [self.tabBarController setSelectedIndex:self.tabBarController.selectedIndex+1];
        }
    }
}

@end
