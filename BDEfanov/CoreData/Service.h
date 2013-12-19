//
//  Service.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 15.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Service : NSManagedObject

@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSNumber * idService;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *contractService;

-(void) setCost:(NSNumber *)myCost;

@end
