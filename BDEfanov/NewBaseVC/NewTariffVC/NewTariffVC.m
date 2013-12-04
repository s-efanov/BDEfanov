//
//  NewTariffVC.m
//  KursovayaBD
//
//  Created by Sergey Efanov on 30.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "NewTariffVC.h"
#import "DetailViewController.h"

@interface NewTariffVC ()

@end

@implementation NewTariffVC

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
    NSManagedObject *tarif = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                            inManagedObjectContext:context];
    
    [tarif setValue:[NSNumber numberWithInteger:1] forKey:@"idTariff"];
    [tarif setValue:textFieldNameTariff.text forKey:@"name"];
    [tarif setValue:[NSNumber numberWithInteger:textFieldCost.text.integerValue] forKey:@"cost"];
    [tarif setValue:[NSNumber numberWithInteger:textFieldSpeed.text.integerValue] forKey:@"speed"];
    
    [context save:nil];
    
    [self.delegate closePopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
