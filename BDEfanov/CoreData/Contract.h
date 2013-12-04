//
//  Contract.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contract : NSManagedObject

@property (nonatomic, retain) NSNumber * idClient;
@property (nonatomic, retain) NSNumber * idContract;
@property (nonatomic, retain) NSNumber * idEquipment;
@property (nonatomic, retain) NSNumber * idOffice;
@property (nonatomic, retain) NSNumber * idTarif;
@property (nonatomic, retain) NSNumber * idWorker;

@end
