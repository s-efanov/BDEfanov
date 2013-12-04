//
//  Dolz.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Dolz : NSManagedObject

@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSNumber * idDolz;
@property (nonatomic, retain) NSNumber * idOffice;
@property (nonatomic, retain) NSString * nameDolz;
@property (nonatomic, retain) NSString * work;

@end
