//
//  NewTariffVC.m
//  KursovayaBD
//
//  Created by Sergey Efanov on 30.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "NewTariffVC.h"
#import "DetailViewController.h"

@interface NewTariffVC (){

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
    
    if(self.object){
        textFieldNameTariff.text = [self.object valueForKey:@"nameTarif"];
        textFieldNameTariff.userInteractionEnabled = NO;
        textFieldNameTariff.backgroundColor = [UIColor lightGrayColor];
        textFieldSpeed.text = [self.object valueForKey:@"speed"];
        textFieldCost.text = [self.object valueForKey:@"cost"];
    }
}

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    
    if(self.object)
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Tarif set speed = %d, cost = %d where nameTarif = '%@'", textFieldSpeed.text.integerValue, textFieldCost.text.integerValue, textFieldNameTariff.text]];
    else
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"insert into Tarif (speed, cost, nameTarif) values (%d, %d, '%@')", textFieldSpeed.text.integerValue, textFieldCost.text.integerValue, textFieldNameTariff.text]];
    
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
