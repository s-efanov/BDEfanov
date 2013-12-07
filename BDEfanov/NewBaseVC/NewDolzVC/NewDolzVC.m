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
#import "Limits.h"

@interface NewDolzVC (){
    NSArray *offices;
    Limits *limits;
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
    limits = [Limits MR_findAll][0];
    
    if(offices.count)
        nameOffice = ((Office*)offices[0]).name;
    
    if(self.object){
        textFieldName.text = ((Dolz*)self.object).nameDolz;
        textFieldWork.text = ((Dolz*)self.object).work;
        textFieldCost.text = ((Dolz*)self.object).cost.stringValue;
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
        self.object = [Dolz MR_createEntity];
        ((Dolz*)self.object).idDolz = [limits nextDolzId];
    }
    
    ((Dolz*)self.object).cost = [NSNumber numberWithInteger:textFieldCost.text.integerValue];
    ((Dolz*)self.object).nameDolz = textFieldName.text;
    ((Dolz*)self.object).work = textFieldWork.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", nameOffice];
    Office *office = [Office MR_findAllWithPredicate:predicate][0];
    ((Dolz*)self.object).parentOffice = office;
    
    if(!self.object){
        [office addDotDolzObject:((Dolz*)self.object)];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldName.text isEqualToString:@""]){
        [str appendString:@"Название должности не может быть пустым\n"];
    }
    
    if([textFieldCost.text isEqualToString:@""]){
        [str appendString:@"Оклад не может быть пустым\n"];
    }
    
    if([textFieldWork.text isEqualToString:@""]){
        [str appendString:@"Обязанности не могут быть пустыми\n"];
    }
    
    if(!offices.count){
        [str appendString:@"В приложении нет офисов\n"];
    }
    
    return str;
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
