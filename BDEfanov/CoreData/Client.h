//
//  Client.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 08.12.13.
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
@property (nonatomic, retain) Contract *parentContract;

@end
