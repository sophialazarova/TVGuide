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
#import "CategorizedScheduleViewController.h"
#import "CategorizedScheduleType.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    MenuView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Menu";
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
    [self pushControllerWithType:CategorizedScheduleTypeMovies title:@"Movies"];
}

-(void) pushSportsController{
    [self pushControllerWithType:CategorizedScheduleTypeSports title:@"Sport"];
}

-(void) pushTVSeriesController{
   [self pushControllerWithType:CategorizedScheduleTypeTVSeries title:@"TV Series"];
}

-(void) pushControllerWithType:(CategorizedScheduleType) type title:(NSString*) title{
    CategorizedScheduleViewController *controller = [[CategorizedScheduleViewController alloc] initWithScheduleType:type];
    controller.header = title;
    [self.navigationController pushViewController:controller animated:YES];
}



@end
