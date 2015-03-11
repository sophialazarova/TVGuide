//
//  TabBarCreatingViewController.m
//  TvGuide
//
//  Created by Admin on 3/10/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "TabBarCreationHelper.h"
#import "Utility.h"

@interface TabBarCreationHelper ()

@end

@implementation TabBarCreationHelper

-(NSArray*) setupTabBarControllers:(NSArray*) controllers{
    NSDate *current = [NSDate date];    
    for(int i = 0; i<controllers.count;i++){
        if (i == 0) {
            [self attachTabBarItemWithName:@"Днес" ToController:controllers[i]];
        }
        else if( i == 1){
            [self attachTabBarItemWithName:@"Утре" ToController:controllers[i]];
        }
        else{
             [self attachTabBarItemWithName:[Utility transformDate:[Utility addDays:i ToDate:current]] ToController:controllers[i]];
        }
    }
    
    NSArray *controllersArray = controllers;
    return controllersArray;
}

-(UITabBarController*) createTabControllerWithControllers:(NSArray*) controllers{
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    NSArray *controllersArray = [self setupTabBarControllers:controllers];
    tabBar.viewControllers = controllersArray;
    return tabBar;
}

-(void) attachTabBarItemWithName:(NSString*) name ToController:(UIViewController*) contr{
    UITabBarItem* tabBar = [[UITabBarItem alloc] initWithTitle:name image:[UIImage imageNamed:@"circle.png"] tag:0];
    tabBar.selectedImage = [UIImage imageNamed:@"checkmark-small.png"];
    contr.tabBarItem = tabBar;
}

@end
