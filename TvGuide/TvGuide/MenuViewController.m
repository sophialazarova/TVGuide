//
//  MenuViewController.m
//  TvGuide
//
//  Created by Admin on 2/18/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuView.h"
#import "MoviesViewController.h"
#import "TVScheduleController.h"
#import "TVSeriesViewController.h"
#import "SportsViewController.h"
#import "ChannelScheduleTableViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    MenuView *view;
}

-(instancetype)init{
    self = [super init];
    if(self){
       
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

/// REFACTOR BELOW SECTION (Pushing next controller) /////

-(void) pushController:(UIViewController*) controller{
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) pushTvScheduleController{
    TVScheduleController *tvController = [[TVScheduleController alloc] init];
       [self.navigationController pushViewController:tvController animated:YES];
}

-(void) pushMoviesController{
    MoviesViewController *moviesController = [[MoviesViewController alloc] init];
    [self.navigationController pushViewController:moviesController animated:YES];
}

-(void) pushSportsController{
    SportsViewController *sportsController = [[SportsViewController alloc] init];
    [self.navigationController pushViewController:sportsController animated:YES];
}

-(void) pushTVSeriesController{
    TVSeriesViewController *seriesController = [[TVSeriesViewController alloc] init];
    [self.navigationController pushViewController:seriesController animated:YES];
}

/// REFACTOR ABOVE SECTION (Pushing next controller) /////

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
