//
//  NewTariffVC.m
//  KursovayaBD
//
//  Created by Sergey Efanov on 30.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "NewTariffVC.h"
#import "Tarifs.h"
#import "DetailViewController.h"
#import "Limits.h"

@interface NewTariffVC (){
    Limits *limits;
}

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
	limits = [Limits MR_findAll][0];
}

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    Tarifs *tarif = [Tarifs MR_createEntity];
    
    tarif.idTariff = [limits nextTarifsId];
    tarif.name = textFieldNameTariff.text;
    tarif.cost = [NSNumber numberWithInteger:textFieldCost.text.integerValue];
    tarif.speed = [NSNumber numberWithInteger:textFieldSpeed.text.integerValue];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldNameTariff.text isEqualToString:@""]){
        [str appendString:@"Название тарифа не может быть пустым\n"];
    }
    
    if([textFieldCost.text isEqualToString:@""]){
        [str appendString:@"Цена не может быть пустой\n"];
    }
    
    if([textFieldSpeed.text isEqualToString:@""]){
        [str appendString:@"Скорость не может быть пустой\n"];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
