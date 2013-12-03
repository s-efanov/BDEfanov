//
//  Tarifs.h
//  BDEfanov
//
//  Created by Сергей on 03.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract;

@interface Tarifs : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * cost;
@property (nonatomic, retain) NSDecimalNumber * idTariff;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Contract *relationship;

@end
