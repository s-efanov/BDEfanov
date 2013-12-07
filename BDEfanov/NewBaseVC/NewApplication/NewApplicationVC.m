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
    NSString *idContract;
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
        idContract = ((Contract*)contracts[0]).idContract.stringValue;
}

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }

    Application *application = [Application MR_createEntity];
    
    application.idApplication = [limits nextApplicationId];
    application.idContract = [NSNumber numberWithInteger:idContract.integerValue];
    application.descriptioncontract = textFieldDescription.text;
    application.closed = [NSNumber numberWithBool:switchClosed.on];
    
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
    idContract = ((Contract*)contracts[row]).idContract.stringValue;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
