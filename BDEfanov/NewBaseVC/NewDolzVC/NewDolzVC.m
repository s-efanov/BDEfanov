//
//  NewDolzVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewDolzVC.h"

@interface NewDolzVC ()

@end

@implementation NewDolzVC

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
    NSManagedObject *dolz = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                            inManagedObjectContext:context];
    
    [dolz setValue:[NSNumber numberWithInteger:1] forKey:@"idDolz"];
    [dolz setValue:[NSNumber numberWithInteger:textFieldCost.text.integerValue] forKey:@"cost"];
    [dolz setValue:textFieldName.text forKey:@"nameDolz"];
    [dolz setValue:[NSNumber numberWithInteger:textFieldOffice.text.integerValue] forKey:@"idOffice"];
    [dolz setValue:textFieldWork.text forKey:@"work"];
    
    [context save:nil];
    
    [self.delegate closePopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
