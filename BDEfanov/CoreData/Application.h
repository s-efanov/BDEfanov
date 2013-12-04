//
//  Application.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Application : NSManagedObject

@property (nonatomic, retain) NSNumber * closed;
@property (nonatomic, retain) NSString * descriptioncontract;
@property (nonatomic, retain) NSNumber * idApplication;
@property (nonatomic, retain) NSNumber * idContract;

@end
