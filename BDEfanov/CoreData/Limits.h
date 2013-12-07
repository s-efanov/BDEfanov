//
//  Limits.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 07.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Limits : NSManagedObject

@property (nonatomic, retain) NSNumber * limApplication;
@property (nonatomic, retain) NSNumber * limClient;
@property (nonatomic, retain) NSNumber * limContract;
@property (nonatomic, retain) NSNumber * limDolz;
@property (nonatomic, retain) NSNumber * limEquipment;
@property (nonatomic, retain) NSNumber * limOffice;
@property (nonatomic, retain) NSNumber * limService;
@property (nonatomic, retain) NSNumber * limTarifs;
@property (nonatomic, retain) NSNumber * limWorker;

-(NSNumber*) nextOfficeId;
-(NSNumber*) nextApplicationId;
-(NSNumber*) nextClientId;
-(NSNumber*) nextContractId;
-(NSNumber*) nextDolzId;
-(NSNumber*) nextEquipmentId;
-(NSNumber*) nextWorkerId;
-(NSNumber*) nextTarifsId;
-(NSNumber*) nextServiceId;

@end
