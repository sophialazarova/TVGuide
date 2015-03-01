//
//  SportsViewController.m
//  TvGuide
//
//  Created by Admin on 2/21/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "SportsViewController.h"
#import "CategorizedSchedulesView.h"

@interface SportsViewController ()

@end

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView{
    CategorizedSchedulesView *sportsView = [[CategorizedSchedulesView alloc] init];
    self.view = sportsView;
}

@end
