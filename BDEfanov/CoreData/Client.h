//
//  Client.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 16.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract;

@interface Client : NSManagedObject

@property (nonatomic, retain) NSString * adress;
@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSNumber * idClient;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * otec;
@property (nonatomic, retain) NSSet *parentContract;
@end

@interface Client (CoreDataGeneratedAccessors)

- (void)addParentContractObject:(Contract *)value;
- (void)removeParentContractObject:(Contract *)value;
- (void)addParentContract:(NSSet *)values;
- (void)removeParentContract:(NSSet *)values;

@end
