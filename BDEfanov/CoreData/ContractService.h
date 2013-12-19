//
//  ContractService.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 15.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract, Service;

@interface ContractService : NSManagedObject

@property (nonatomic, retain) NSSet *parentContract;
@property (nonatomic, retain) NSSet *parentService;
@end

@interface ContractService (CoreDataGeneratedAccessors)

- (void)addParentContractObject:(Contract *)value;
- (void)removeParentContractObject:(Contract *)value;
- (void)addParentContract:(NSSet *)values;
- (void)removeParentContract:(NSSet *)values;

- (void)addParentServiceObject:(Service *)value;
- (void)removeParentServiceObject:(Service *)value;
- (void)addParentService:(NSSet *)values;
- (void)removeParentService:(NSSet *)values;

@end
