//
//  NewWorkerVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewWorkerVC.h"

@interface NewWorkerVC ()

@end

@implementation NewWorkerVC

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
    NSManagedObject *worker = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                            inManagedObjectContext:context];
    
    [worker setValue:[NSNumber numberWithInteger:1] forKey:@"idWorker"];
    [worker setValue:textFieldAdress.text forKey:@"adress"];
    [worker setValue:[NSNumber numberWithInteger:textFieldDolz.text.integerValue] forKey:@"idDolz"];
    [worker setValue:birthDate.date forKey:@"birthdate"];
    [worker setValue:[NSNumber numberWithBool:switchMed.on] forKey:@"med"];
    [worker setValue:textFieldName.text forKey:@"name"];
    [worker setValue:textFieldLastName.text forKey:@"lastname"];
    [worker setValue:textFieldOtec.text forKey:@"otec"];
    [worker setValue:textFieldPasseport.text forKey:@"passeport"];
    [worker setValue:[NSNumber numberWithInteger:textFieldTel.text.integerValue] forKey:@"tel"];
    
    [context save:nil];
    
    [self.delegate closePopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
