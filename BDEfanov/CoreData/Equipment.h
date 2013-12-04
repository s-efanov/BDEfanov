//
//  Equipment.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Equipment : NSManagedObject

@property (nonatomic, retain) NSString * firm;
@property (nonatomic, retain) NSNumber * idEquipment;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSNumber * scancode;

@end
