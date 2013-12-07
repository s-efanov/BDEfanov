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
#import "AppDelegate.h"
#import "Limits.h"

@interface NewOfficeVC (){
    Limits *limits;
}

@end

@implementation NewOfficeVC

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    
    Office *office = [Office MR_createEntity];
    
    office.idOffice = [limits nextOfficeId];
    office.name = textFieldNameOffice.text;
    office.adress = textFieldAdress.text;
    office.index = [NSNumber numberWithInteger:textFieldIndex.text.integerValue];
    office.info = textFieldInfo.text;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldNameOffice.text isEqualToString:@""]){
        [str appendString:@"Название офиса не может быть пустым\n"];
    }
    
    if([textFieldAdress.text isEqualToString:@""]){
        [str appendString:@"Адрес офиса не может быть пустым\n"];
    }
    
    if([textFieldIndex.text isEqualToString:@""]){
        [str appendString:@"Индекс не может быть пустым\n"];
    }
    
    if([textFieldInfo.text isEqualToString:@""]){
        [str appendString:@"Информация не может быть пустой\n"];
    }
    
    return str;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    limits = [Limits MR_findAll][0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
