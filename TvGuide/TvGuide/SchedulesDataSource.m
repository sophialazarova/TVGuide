//
//  SchedulesDataSource.m
//  TvGuide
//
//  Created by Sophiya Lazarova on 11/3/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import "SchedulesDataSource.h"
#import "UIColor+HexRepresentation.h"
#import "ChannelScheduleItemTableViewCell.h"

@implementation SchedulesDataSource

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[ChannelScheduleItemTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.data = [NSArray new];
    self.tableView.backgroundColor = [UIColor colorWithHexValue:@"FDF9E2" alpha:1.0];
    _isLoaded = NO;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelScheduleItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = [self.data[indexPath.row] title];
    cell.time.text = [self.data[indexPath.row] time];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _isLoaded = YES;
    return cell;
}
@end
