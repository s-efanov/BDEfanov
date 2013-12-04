//
//  Office.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract;

@interface Office : NSManagedObject

@property (nonatomic, retain) NSString * adress;
@property (nonatomic, retain) NSDecimalNumber * idOffice;
@property (nonatomic, retain) NSDecimalNumber * index;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface Office (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Contract *)value;
- (void)removeRelationshipObject:(Contract *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
