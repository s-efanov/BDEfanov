//
//  Application.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 08.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contract;

@interface Application : NSManagedObject

@property (nonatomic, retain) NSNumber * closed;
@property (nonatomic, retain) NSString * descriptioncontract;
@property (nonatomic, retain) NSNumber * idApplication;
@property (nonatomic, retain) Contract *parentContract;

@end
