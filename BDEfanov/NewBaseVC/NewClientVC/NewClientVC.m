//
//  NewClientVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewClientVC.h"
#import "Client.h"
#import "Limits.h"

@interface NewClientVC (){
    Limits *limits;
}

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
	limits = [Limits MR_findAll][0];
    
    if(self.object){
        textFieldName.text = ((Client*)self.object).name;
        textFieldOtec.text = ((Client*)self.object).otec;
        textFieldLastName.text = ((Client*)self.object).lastName;
        textFieldAdress.text = ((Client*)self.object).adress;
    }
}

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    
    if(!self.object){
        self.object = [Client MR_createEntity];
        ((Client*)self.object).idClient = [limits nextClientId];
    }
    
    ((Client*)self.object).adress = textFieldAdress.text;
    ((Client*)self.object).birthdate = birthDate.date;
    ((Client*)self.object).name = textFieldName.text;
    ((Client*)self.object).lastName = textFieldLastName.text;
    ((Client*)self.object).otec = textFieldOtec.text;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldName.text isEqualToString:@""]){
        [str appendString:@"Имя не может быть пустым\n"];
    }
    
    if([textFieldLastName.text isEqualToString:@""]){
        [str appendString:@"Фамилия не может быть пустой\n"];
    }
    
    if([textFieldOtec.text isEqualToString:@""]){
        [str appendString:@"Отчество не может быть пустым\n"];
    }
    
    if([textFieldAdress.text isEqualToString:@""]){
        [str appendString:@"Адрес не может быть пустым\n"];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
