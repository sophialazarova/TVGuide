//
//  MenuViewController.m
//  TvGuide
//
//  Created by Admin on 2/18/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuView.h"
#import "ChannelsTableViewController.h"
#import "CategorizedScheduleType.h"
#import "Utility.h"
#import "SchedulesViewController.h"
#import "ChannelsTableViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    MenuView *view;
    BOOL _isInitialLoad;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Меню";
    [self setupButtonsActions];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    self.navigationController.navigationBar.translucent = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    if (_isInitialLoad){
      [view showIcons];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    if (!_isInitialLoad) {
        [view showIcons];
    }
    _isInitialLoad = YES;
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
    ChannelsTableViewController *tvController = [[ChannelsTableViewController alloc] init];
    [self.navigationController pushViewController:tvController animated:YES];
}

-(void) pushMoviesController{
    [self pushScheduleControllerWithName:@"Филми" type:CategorizedScheduleTypeMovies];
}

-(void) pushSportsController {

    [self pushScheduleControllerWithName:@"Спорт" type:CategorizedScheduleTypeSports];
}

-(void) pushTVSeriesController {

    [self pushScheduleControllerWithName:@"Сериали" type:CategorizedScheduleTypeTVSeries];
}

-(void) pushScheduleControllerWithName:(NSString*)name type:(CategorizedScheduleType)type {
    SchedulesViewController *ctr = [[SchedulesViewController alloc]  init];
    ctr.isCategorized = YES;
    ctr.queryType = type;
    ctr.channelName = name;
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
