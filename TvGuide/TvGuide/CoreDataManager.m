//
//  CoreDataManager.m
//  TvGuide
//
//  Created by Admin on 1/13/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager{
    NSString* database;
}

+(instancetype)getManager{
    static CoreDataManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[CoreDataManager alloc] init];
    });
    
    return manager;
}

-(instancetype)init{
    self = [super init];
    if(self){
        database = @"Channel.sqlite";
        self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
        self.coordinator = [[NSPersistentStoreCoordinator alloc]
                            initWithManagedObjectModel:self.model];
        [self.context setPersistentStoreCoordinator:self.coordinator];
        
    }
    
    return self;
}

-(void)setupCoreData{
    [self loadStore];
}

-(void)saveContext{
    if([self.context hasChanges]){
        NSError* error = nil;
        if([self.context save:&error]){
            NSLog(@"context SAVED changes to persistent store");
        } else {
            NSLog(@"Failed to save context: %@", error);
        }
    } else {
        NSLog(@"SKIPPED context save, there are no changes!");
    }
}

-(void) loadStore{
    if(self.store){
        return;
    }
    
    NSError *error = nil;
    self.store = [self.coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self getStoreURL] options:nil error:&error];
    
    if(!self.store){
        NSLog(@"Failed to add store. Error: %@", error);
        abort();
    } else {
        NSLog(@"Successfully added store: %@", self.store);
    }
}

-(NSURL*) getStoreURL{
    return [[self getApplicationStoresDirectory] URLByAppendingPathComponent:database];
}

- (NSURL *)getApplicationStoresDirectory
{
    NSURL *storesDirectory =
    [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
     URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error]) {
            NSLog(@"Successfully created Stores directory");
        }
        else {NSLog(@"FAILED to create Stores directory: %@", error);}
    }
    
    return storesDirectory;
}

- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
}

@end
