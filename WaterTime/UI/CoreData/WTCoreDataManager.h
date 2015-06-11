//
//  WTCoreDataManager.h
//  WaterTime
//
//  Created by WaterLiu on 15/2/6.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface WTCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)installDataBase;
- (void)uninstallDataBase;

@end
