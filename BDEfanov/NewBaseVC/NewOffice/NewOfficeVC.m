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
    
    if(!self.object){
        self.object = [Office MR_createEntity];
        ((Office*)self.object).idOffice = [limits nextOfficeId];
    }
    ((Office*)self.object).name = textFieldNameOffice.text;
    ((Office*)self.object).adress = textFieldAdress.text;
    ((Office*)self.object).index = [NSNumber numberWithInteger:textFieldIndex.text.integerValue];
    ((Office*)self.object).info = textFieldInfo.text;
    
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
    
    if(self.object){
        textFieldAdress.text = ((Office*)self.object).adress;
        textFieldIndex.text = ((Office*)self.object).index.stringValue;
        textFieldInfo.text = ((Office*)self.object).info;
        textFieldNameOffice.text = ((Office*)self.object).name;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
