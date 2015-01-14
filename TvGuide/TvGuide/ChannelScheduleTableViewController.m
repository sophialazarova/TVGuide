//
//  ChannelScheduleTableViewController.m
//  TvGuide
//
//  Created by Admin on 1/4/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "ChannelScheduleTableViewController.h"
#import "ChannelScheduleItemTableViewCell.h"
#import "ChannelScheduleEntry.h"

@interface ChannelScheduleTableViewController ()

@end

@implementation ChannelScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *contr = [self.navigationController.viewControllers objectAtIndex:1];
    contr.navigationItem.title = self.header;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.schedule count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChannelScheduleItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelScheduleItem" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[ChannelScheduleItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"channelScheduleItem"];
    }
    
    ChannelScheduleEntry *entry = [self.schedule objectAtIndex:indexPath.row];
    cell.title.text = entry.title;
    cell.time.text = entry.time;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
