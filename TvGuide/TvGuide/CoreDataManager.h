//
//  CoreDataManager.h
//  TvGuide
//
//  Created by Admin on 1/13/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property(nonatomic,strong) NSManagedObjectContext* context;
@property(nonatomic,strong) NSManagedObjectModel* model;
@property(nonatomic,strong) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic,strong) NSPersistentStore* store;

+(instancetype) getManager;
-(void)saveContext;
-(void)setupCoreData;
@end
