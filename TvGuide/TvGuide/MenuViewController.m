//
//  MenuViewController.m
//  TvGuide
//
//  Created by Admin on 2/18/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuView.h"
#import "TVScheduleController.h"
#import "ChannelScheduleTableViewController.h"
#import "CategorizedScheduleType.h"
#import "CategorizedSchedulesTableViewController.h"
#import "Utility.h"
#import "TabBarCreationHelper.h"
#import "MainScheduleType.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    MenuView *view;
    TabBarCreationHelper *tabBarHelper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tabBarHelper = [[TabBarCreationHelper alloc] init];
    self.navigationItem.title = @"Меню";
    [self setupButtonsActions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
         [view showIcons];
}

-(void) setupButtonsActions{
    [view.TVIcon addAction:@selector(pushTvScheduleController) caller:self];
    [view.moviesIcon addAction:@selector(pushMoviesController) caller:self];
    [view.seriesIcon addAction:@selector(pushTVSeriesController) caller:self];
    [view.sportsIcon addAction:@selector(pushSportsController) caller:self];
}

-(void)loadView{
     view = [[MenuView alloc] init];
    self.view = view;
}

-(void) pushTvScheduleController{
    TVScheduleController *tvController = [[TVScheduleController alloc] init];
    [self.navigationController pushViewController:tvController animated:YES];
}
-(void) pushMoviesController{
    NSArray *controllers = [self createTabBarCategorizedControllersWithType:CategorizedScheduleTypeMovies];
    UITabBarController *tabbar = [tabBarHelper createTabControllerWithControllers:controllers];
    [self.navigationController pushViewController:tabbar animated:YES];
    tabbar.navigationItem.title = @"Филми";
}

-(void) pushSportsController{
    NSArray *controllers = [self createTabBarCategorizedControllersWithType:CategorizedScheduleTypeSports];
    UITabBarController *tabbar = [tabBarHelper createTabControllerWithControllers:controllers];
    [self.navigationController pushViewController:tabbar animated:YES];
    tabbar.navigationItem.title = @"Спорт";
}

-(void) pushTVSeriesController{
    NSArray *controllers = [self createTabBarCategorizedControllersWithType:CategorizedScheduleTypeTVSeries];
    UITabBarController *tabbar = [tabBarHelper createTabControllerWithControllers:controllers];
    [self.navigationController pushViewController:tabbar animated:YES];
    tabbar.navigationItem.title = @"Сериали";
}

-(NSArray*) createTabBarCategorizedControllersWithType:(CategorizedScheduleType) type{
    NSDate *today = [NSDate date];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i<5; i++) {
        CategorizedSchedulesTableViewController *contr = [[CategorizedSchedulesTableViewController alloc] initWithType:type searchDate:[Utility addDays:i ToDate:today]];
        [result addObject:contr];
    }
    
    return result;
}

@end
