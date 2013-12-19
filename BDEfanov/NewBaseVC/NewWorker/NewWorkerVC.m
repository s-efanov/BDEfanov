//
//  NewWorkerVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewWorkerVC.h"
#import "Dolz.h"
#import "Worker.h"
#import "Limits.h"

@interface NewWorkerVC (){
    NSArray *dolzs;
    Limits *limits;
    NSString *nameDolz;
}

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
	dolzs = [Dolz MR_findAll];
    limits = [Limits MR_findAll][0];
    
    if(dolzs.count)
        nameDolz = ((Dolz*)dolzs[0]).nameDolz;
    
    if(self.object){
        textFieldName.text = ((Worker*)self.object).name;
        textFieldLastName.text = ((Worker*)self.object).lastname;
        textFieldOtec.text = ((Worker*)self.object).otec;
        textFieldPasseport.text = ((Worker*)self.object).passeport;
        textFieldAdress.text = ((Worker*)self.object).adress;
        textFieldTel.text = ((Worker*)self.object).tel.stringValue;
        switchMed.on = ((Worker*)self.object).med.boolValue;
    }
}

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    
    Worker *worker = [Worker MR_createEntity];
    
    worker.idWorker = [limits nextWorkerId];
    worker.adress = textFieldAdress.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nameDolz = %@", nameDolz];
    Dolz *dolz = [Dolz MR_findAllWithPredicate:predicate][0];
    worker.parentDolz = dolz;
    
    worker.birthdate = birthDate.date;
    worker.med = [NSNumber numberWithBool:switchMed.on];
    worker.name = textFieldName.text;
    worker.lastname = textFieldLastName.text;
    worker.otec = textFieldOtec.text;
    worker.passeport = textFieldPasseport.text;
    worker.tel = [NSNumber numberWithInteger:textFieldTel.text.integerValue];
    
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
    
    if([textFieldPasseport.text isEqualToString:@""]){
        [str appendString:@"Номер паспорта не может быть пустым\n"];
    }
    
    if([textFieldTel.text isEqualToString:@""]){
        [str appendString:@"Телефон не может быть пустым\n"];
    }
    
    if([textFieldAdress.text isEqualToString:@""]){
        [str appendString:@"Адрес не может быть пустым\n"];
    }
    
    if(!dolzs.count){
        [str appendString:@"В организации нет должностей\n"];
    }
    
    return str;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return dolzs.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return ((Dolz*)dolzs[row]).nameDolz;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    nameDolz = ((Dolz*)dolzs[row]).nameDolz;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
