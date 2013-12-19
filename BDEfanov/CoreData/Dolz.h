//
//  Dolz.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 15.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Office, Worker;

@interface Dolz : NSManagedObject

@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSNumber * idDolz;
@property (nonatomic, retain) NSString * nameDolz;
@property (nonatomic, retain) NSString * work;
@property (nonatomic, retain) NSSet *dotWorker;
@property (nonatomic, retain) Office *parentOffice;
@end

@interface Dolz (CoreDataGeneratedAccessors)

- (void)addDotWorkerObject:(Worker *)value;
- (void)removeDotWorkerObject:(Worker *)value;
- (void)addDotWorker:(NSSet *)values;
- (void)removeDotWorker:(NSSet *)values;

@end
