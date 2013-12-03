//
//  Contract.h
//  BDEfanov
//
//  Created by Сергей on 03.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contract : NSManagedObject

@property (nonatomic, retain) NSNumber * idContract;
@property (nonatomic, retain) NSNumber * idOffice;

@end
