//
//  NewClientVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewClientVC.h"

@interface NewClientVC ()

@end

@implementation NewClientVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(IBAction)btnSave:(id)sender{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *client = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                            inManagedObjectContext:context];
    
    [client setValue:[NSNumber numberWithInteger:1] forKey:@"idClient"];
    [client setValue:textFieldAdress.text forKey:@"adress"];
    [client setValue:birthDate.date forKey:@"birthdate"];
    [client setValue:textFieldName.text forKey:@"name"];
    [client setValue:textFieldLastName.text forKey:@"lastName"];
    [client setValue:textFieldOtec.text forKey:@"otec"];
    
    [context save:nil];
    
    [self.delegate closePopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
