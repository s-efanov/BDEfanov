//
//  NewDolzVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewDolzVC.h"
#import "Office.h"
#import "Dolz.h"

@interface NewDolzVC (){
    NSArray *offices;
    NSString *nameOffice;
}

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
	offices = [Office MR_findAll];
}

-(IBAction)btnSave:(id)sender{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *dolz = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                            inManagedObjectContext:context];
    
    [dolz setValue:[NSNumber numberWithInteger:1] forKey:@"idDolz"];
    [dolz setValue:[NSNumber numberWithInteger:textFieldCost.text.integerValue] forKey:@"cost"];
    [dolz setValue:textFieldName.text forKey:@"nameDolz"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", nameOffice];
    Office *office = [Office MR_findAllWithPredicate:predicate][0];
    [dolz setValue:office.idOffice forKey:@"idOffice"];
    
    [dolz setValue:textFieldWork.text forKey:@"work"];
    
    [context save:nil];
    
    [self.delegate closePopover];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return offices.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return ((Office*)offices[row]).name;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   nameOffice = ((Office*)offices[row]).name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
