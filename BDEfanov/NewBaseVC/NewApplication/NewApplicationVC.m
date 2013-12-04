//
//  NewApplicationVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewApplicationVC.h"

@interface NewApplicationVC ()

@end

@implementation NewApplicationVC

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
    NSManagedObject *application = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                            inManagedObjectContext:context];
    
    [application setValue:[NSNumber numberWithInteger:1] forKey:@"idApplication"];
    [application setValue:[NSNumber numberWithInteger:textFieldContract.text.integerValue] forKey:@"idContract"];
    [application setValue:textFieldDescription.text forKey:@"descriptioncontract"];
    [application setValue:[NSNumber numberWithBool:switchClosed.on] forKey:@"closed"];
    
    [context save:nil];
    
    [self.delegate closePopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
