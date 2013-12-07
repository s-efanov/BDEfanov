//
//  NewApplicationVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewApplicationVC.h"
#import "Contract.h"
#import "Application.h"
#import "Limits.h"

@interface NewApplicationVC (){
    NSArray *contracts;
    Contract *contract;
    Limits *limits;
}

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
	contracts = [Contract MR_findAll];
    limits = [Limits MR_findAll][0];
    
    if(contracts.count)
        contract = contracts[0];
    
    if(self.object){
        textFieldDescription.text = ((Application*)self.object).descriptioncontract;
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
        self.object = [Application MR_createEntity];
        ((Application*)self.object).idApplication = [limits nextApplicationId];
    }
    
    ((Application*)self.object).parentContract = contract;
    ((Application*)self.object).descriptioncontract = textFieldDescription.text;
    ((Application*)self.object).closed = [NSNumber numberWithBool:switchClosed.on];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldDescription.text isEqualToString:@""]){
        [str appendString:@"Описание не может быть пустым\n"];
    }
    
    if(!contracts.count){
        [str appendString:@"В приложении нет договоров\n"];
    }
    
    return str;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return contracts.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return ((Contract*)contracts[row]).idContract.stringValue;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    contract = contracts[row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
