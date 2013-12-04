//
//  NewContractVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewContractVC.h"

@interface NewContractVC ()

@end

@implementation NewContractVC

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
    NSManagedObject *contract = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                            inManagedObjectContext:context];
    
    [contract setValue:[NSNumber numberWithInteger:1] forKey:@"idContract"];
    [contract setValue:[NSNumber numberWithInteger:textFieldClient.text.integerValue] forKey:@"idClient"];
    [contract setValue:[NSNumber numberWithInteger:textFieldRouter.text.integerValue] forKey:@"idEquipment"];
    [contract setValue:[NSNumber numberWithInteger:textFieldOffice.text.integerValue] forKey:@"idOffice"];
    [contract setValue:[NSNumber numberWithInteger:textFieldTarif.text.integerValue] forKey:@"idTarif"];
    [contract setValue:[NSNumber numberWithInteger:textFieldWorker.text.integerValue] forKey:@"idWorker"];
    
    [context save:nil];
    
    [self.delegate closePopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
