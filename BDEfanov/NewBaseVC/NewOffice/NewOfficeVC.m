//
//  NewOfficeVC.m
//  KursovayaBD
//
//  Created by Sergey Efanov on 28.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "NewOfficeVC.h"
#import "DetailViewController.h"
#import "Office.h"

@interface NewOfficeVC ()

@end

@implementation NewOfficeVC

-(IBAction)btnSave:(id)sender{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *office = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                                      inManagedObjectContext:context];
    
    [office setValue:[NSNumber numberWithInteger:1] forKey:@"idOffice"];
    [office setValue:textFieldNameOffice.text forKey:@"name"];
    [office setValue:textFieldAdress.text forKey:@"adress"];
    [office setValue:[NSNumber numberWithInteger:textFieldIndex.text.integerValue] forKey:@"index"];
    [office setValue:textFieldInfo.text forKey:@"info"];
    
    [context save:nil];
    
    [self.delegate closePopover];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
