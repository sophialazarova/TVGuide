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

@interface MenuViewController ()

@end

@implementation MenuViewController{
    MenuView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UITabBarController *cont = [self createTabControllerForScheduleType:CategorizedScheduleTypeMovies];
    [self.navigationController pushViewController:cont animated:YES];
    cont.navigationItem.title = @"Филми";
}

-(void) pushSportsController{
    UITabBarController *cont = [self createTabControllerForScheduleType:CategorizedScheduleTypeSports];
    [self.navigationController pushViewController:cont animated:YES];
    cont.navigationItem.title = @"Спорт";
}

-(void) pushTVSeriesController{
    UITabBarController *cont = [self createTabControllerForScheduleType:CategorizedScheduleTypeTVSeries];
    [self.navigationController pushViewController:cont animated:YES];
    cont.navigationItem.title = @"Сериали";
}

-(UITabBarController*) createTabControllerForScheduleType:(CategorizedScheduleType) type{
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    
    
    NSArray *controllersArray = [self initializeTabBarControllersWithType:type];
    tabBar.viewControllers = controllersArray;
    
    return tabBar;
}

-(NSArray*) initializeTabBarControllersWithType:(CategorizedScheduleType) type{
    NSDate *current = [NSDate date];
    NSDate *tomorrowDate = [self addDays:1 ToDate:current];
    NSDate *thirdDate = [self addDays:2 ToDate:current];
    NSDate *fourthDate = [self addDays:3 ToDate:current];
    NSDate *fifthDate = [self addDays:4 ToDate:current];
    
    CategorizedSchedulesTableViewController *today = [[CategorizedSchedulesTableViewController alloc] initWithType:type searchDate:current];
    CategorizedSchedulesTableViewController *tomorrow = [[CategorizedSchedulesTableViewController alloc] initWithType:type searchDate:tomorrowDate];
    CategorizedSchedulesTableViewController *thirdDay = [[CategorizedSchedulesTableViewController alloc] initWithType:type searchDate:thirdDate];
    CategorizedSchedulesTableViewController *fourthDay = [[CategorizedSchedulesTableViewController alloc] initWithType:type searchDate:fourthDate];
    CategorizedSchedulesTableViewController *fifthDay = [[CategorizedSchedulesTableViewController alloc] initWithType:type searchDate:fifthDate];
    
    [self attachTabBarItemWithName:@"Днес" ToController:today];
    [self attachTabBarItemWithName:@"Утре" ToController:tomorrow];
    [self attachTabBarItemWithName:[Utility transformDate:thirdDate] ToController:thirdDay];
    [self attachTabBarItemWithName:[Utility transformDate:fourthDate] ToController:fourthDay];
    [self attachTabBarItemWithName:[Utility transformDate:fifthDate] ToController:fifthDay];
    
    NSArray *controllersArray = [NSArray arrayWithObjects:today,tomorrow,thirdDay,fourthDay,fifthDay, nil];
    return controllersArray;
}

-(NSDate*) addDays:(NSInteger) days ToDate:(NSDate*) date{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    NSDate *result = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    return result;
}

-(void) attachTabBarItemWithName:(NSString*) name ToController:(UIViewController*) contr{
    UITabBarItem* tabBar = [[UITabBarItem alloc] initWithTitle:name image:[UIImage imageNamed:@"circle.png"] tag:0];
    tabBar.selectedImage = [UIImage imageNamed:@"checkmark-small.png"];
    contr.tabBarItem = tabBar;
}




@end
