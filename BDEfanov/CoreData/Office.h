//
//  Office.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 15.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract, Dolz;

@interface Office : NSManagedObject

@property (nonatomic, retain) NSString * adress;
@property (nonatomic, retain) NSNumber * idOffice;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *contract;
@property (nonatomic, retain) NSSet *dotDolz;
@end

@interface Office (CoreDataGeneratedAccessors)

- (void)addContractObject:(Contract *)value;
- (void)removeContractObject:(Contract *)value;
- (void)addContract:(NSSet *)values;
- (void)removeContract:(NSSet *)values;

- (void)addDotDolzObject:(Dolz *)value;
- (void)removeDotDolzObject:(Dolz *)value;
- (void)addDotDolz:(NSSet *)values;
- (void)removeDotDolz:(NSSet *)values;

@end
