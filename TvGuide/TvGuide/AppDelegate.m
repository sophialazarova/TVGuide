//
//  AppDelegate.m
//  TvGuide
//
//  Created by Admin on 1/3/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataManager.h"
#import "LoadingChannelHelper.h"
#import "Channel.h"
#import "MenuViewController.h"
#import "UIColor+HexRepresentation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CoreDataManager *manager = [CoreDataManager getManager];
    LoadingChannelHelper *channelsHelper = [[LoadingChannelHelper alloc] init];
    [manager setupCoreData];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Channel"];
    NSArray *fetchedObjects = [manager.context executeFetchRequest:request error:nil];
    if([fetchedObjects count] == 0){
        [channelsHelper loadChannels];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MenuViewController *root = [[MenuViewController alloc] init];
    UINavigationController *navbar = [[UINavigationController alloc] initWithRootViewController:root];
    navbar.interactivePopGestureRecognizer.enabled = NO;
    navbar.navigationBar.translucent = NO;
    self.window.rootViewController = navbar;
    [self.window addSubview:navbar.view];
    navbar.navigationBar.barTintColor = [UIColor colorWithRed:0.992f green:0.976f blue:0.886f alpha:1.00f];
    navbar.navigationBar.tintColor = [UIColor blackColor];
    navbar.navigationBar.translucent = YES;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
