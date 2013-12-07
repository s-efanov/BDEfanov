//
//  Equipment.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 08.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract;

@interface Equipment : NSManagedObject

@property (nonatomic, retain) NSString * firm;
@property (nonatomic, retain) NSNumber * idEquipment;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSNumber * scancode;
@property (nonatomic, retain) NSSet *contract;
@end

@interface Equipment (CoreDataGeneratedAccessors)

- (void)addContractObject:(Contract *)value;
- (void)removeContractObject:(Contract *)value;
- (void)addContract:(NSSet *)values;
- (void)removeContract:(NSSet *)values;

@end
