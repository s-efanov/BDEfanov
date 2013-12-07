//
//  Limits.m
//  BDEfanov
//
//  Created by Ефанов Сергей on 07.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "Limits.h"


@implementation Limits

@dynamic limApplication;
@dynamic limClient;
@dynamic limContract;
@dynamic limDolz;
@dynamic limEquipment;
@dynamic limOffice;
@dynamic limService;
@dynamic limTarifs;
@dynamic limWorker;

-(NSNumber*) nextWorkerId{
    NSInteger index = self.limWorker.integerValue;
    self.limWorker = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

-(NSNumber*) nextTarifsId{
    NSInteger index = self.limTarifs.integerValue;
    self.limTarifs = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

-(NSNumber*) nextServiceId{
    NSInteger index = self.limService.integerValue;
    self.limService = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

-(NSNumber*) nextEquipmentId{
    NSInteger index = self.limEquipment.integerValue;
    self.limEquipment = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

-(NSNumber*) nextOfficeId{
    NSInteger index = self.limOffice.integerValue;
    self.limOffice = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

-(NSNumber*) nextApplicationId{
    NSInteger index = self.limApplication.integerValue;
    self.limApplication = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

-(NSNumber*) nextClientId{
    NSInteger index = self.limClient.integerValue;
    self.limClient = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

-(NSNumber*) nextDolzId{
    NSInteger index = self.limDolz.integerValue;
    self.limDolz = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

-(NSNumber*) nextContractId{
    NSInteger index = self.limContract.integerValue;
    self.limContract = [NSNumber numberWithInteger: index + 1];
    return [NSNumber numberWithInteger: index];
}

@end
