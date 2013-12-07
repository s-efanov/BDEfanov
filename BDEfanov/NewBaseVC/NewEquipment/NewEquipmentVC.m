//
//  NewEquipmentVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewEquipmentVC.h"
#import "Equipment.h"
#import "Limits.h"

@interface NewEquipmentVC (){
    Limits *limits;
}

@end

@implementation NewEquipmentVC

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
        textFieldFirm.text = ((Equipment*)self.object).firm;
        textFieldModel.text = ((Equipment*)self.object).model;
        textFieldScancode.text = ((Equipment*)self.object).scancode.stringValue;
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
        self.object = [Equipment MR_createEntity];
        ((Equipment*)self.object).idEquipment = [limits nextEquipmentId];
    }
    
    ((Equipment*)self.object).firm = textFieldFirm.text;
    ((Equipment*)self.object).model = textFieldModel.text;
    ((Equipment*)self.object).scancode = [NSNumber numberWithInteger:textFieldScancode.text.integerValue];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldFirm.text isEqualToString:@""]){
        [str appendString:@"Фирма не может быть пустой\n"];
    }
    
    if([textFieldModel.text isEqualToString:@""]){
        [str appendString:@"Модель не может быть пустой\n"];
    }
    
    if([textFieldScancode.text isEqualToString:@""]){
        [str appendString:@"Скан код не может быть пустым\n"];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
