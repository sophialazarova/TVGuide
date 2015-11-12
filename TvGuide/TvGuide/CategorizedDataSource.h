//
//  CategorizedDataSource.h
//  TvGuide
//
//  Created by Sophia on 11/12/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CategorizedDataSource : UITableViewController

@property(strong, nonatomic) NSArray *data;

@property(assign, nonatomic) BOOL isLoaded;

@end
