//
//  Office.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 07.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract;

@interface Office : NSManagedObject

@property (nonatomic, retain) NSString * adress;
@property (nonatomic, retain) NSNumber * idOffice;
@property (nonatomic, retain) NSNumber * index;
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
