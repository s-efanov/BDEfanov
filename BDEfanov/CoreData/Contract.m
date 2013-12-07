//
//  Contract.m
//  BDEfanov
//
//  Created by Ефанов Сергей on 08.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "Contract.h"
#import "Application.h"
#import "Client.h"
#import "Equipment.h"
#import "Office.h"
#import "Service.h"
#import "Tarifs.h"
#import "Worker.h"


@implementation Contract

@dynamic idContract;
@dynamic dotApplication;
@dynamic parentClient;
@dynamic parentEquipment;
@dynamic parentOffice;
@dynamic parentService;
@dynamic parentTarif;
@dynamic parentWorker;

@end
