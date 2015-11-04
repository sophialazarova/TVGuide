//
//  SchedulesDataSource.m
//  TvGuide
//
//  Created by Sophiya Lazarova on 11/3/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import "SchedulesDataSource.h"

@implementation SchedulesDataSource

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
@end
