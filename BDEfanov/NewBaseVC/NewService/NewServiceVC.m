//
//  NewServiceVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewServiceVC.h"
#import "Service.h"
#import "Limits.h"

@interface NewServiceVC (){
    Limits *limits;
}

@end

@implementation NewServiceVC

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
        textFieldCost.text = ((Service*)self.object).cost.stringValue;
        textFieldName.text = ((Service*)self.object).name;
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
        self.object = [Service MR_createEntity];
        ((Service*)self.object).idService = [limits nextServiceId];
    }
    
    ((Service*)self.object).name = textFieldName.text;
    ((Service*)self.object).cost = [NSNumber numberWithInteger:textFieldCost.text.integerValue];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldCost.text isEqualToString:@""]){
        [str appendString:@"Стоимость не может быть пустой\n"];
    }
    
    if([textFieldName.text isEqualToString:@""]){
        [str appendString:@"Название услуги не может быть пустым\n"];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
