//
//  Contract.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 15.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Application, Client, Equipment, Office, Tarifs, Worker;

@interface Contract : NSManagedObject

@property (nonatomic, retain) NSNumber * idContract;
@property (nonatomic, retain) NSSet *dotApplication;
@property (nonatomic, retain) Client *parentClient;
@property (nonatomic, retain) NSManagedObject *parentContractService;
@property (nonatomic, retain) Equipment *parentEquipment;
@property (nonatomic, retain) Office *parentOffice;
@property (nonatomic, retain) Tarifs *parentTarif;
@property (nonatomic, retain) Worker *parentWorker;
@end

@interface Contract (CoreDataGeneratedAccessors)

- (void)addDotApplicationObject:(Application *)value;
- (void)removeDotApplicationObject:(Application *)value;
- (void)addDotApplication:(NSSet *)values;
- (void)removeDotApplication:(NSSet *)values;

@end
