//
//  Service.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 08.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract;

@interface Service : NSManagedObject

@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSNumber * idService;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *contract;
@end

@interface Service (CoreDataGeneratedAccessors)

- (void)addContractObject:(Contract *)value;
- (void)removeContractObject:(Contract *)value;
- (void)addContract:(NSSet *)values;
- (void)removeContract:(NSSet *)values;

@end
