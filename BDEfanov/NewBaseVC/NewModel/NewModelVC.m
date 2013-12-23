//
//  NewModelVC.m
//  BDEfanov
//
//  Created by Ефанов Сергей on 22.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewModelVC.h"

@interface NewModelVC ()

@end

@implementation NewModelVC

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
        textFieldFirma.userInteractionEnabled = NO;
        textFieldFirma.backgroundColor = [UIColor lightGrayColor];
        textFieldModel.userInteractionEnabled = NO;
        textFieldModel.backgroundColor = [UIColor lightGrayColor];
        
        textFieldFirma.text = [self.object valueForKey:@"firma"];
        textFieldModel.text = [self.object valueForKey:@"model"];
        textFieldMaxSpeed.text = [self.object valueForKey:@"maxSpeed"];
        textFieldSlots.text = [self.object valueForKey:@"numberSlot"];
        wifi.on = ((NSString*)[self.object valueForKey:@"wifi"]).boolValue;
        return;
    }
    
    wifi.on = NO;
}

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }

    if(self.object)
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Model set maxSpeed = %d, numberSlot = %d, wifi = %d where firma = '%@' and model =  '%@'", textFieldMaxSpeed.text.integerValue, textFieldSlots.text.integerValue, wifi.on, textFieldFirma.text, textFieldModel.text]];
    else
        [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"insert into Model (firma, model, maxSpeed, numberSlot, wifi) values ('%@', '%@', %d, %d, %d)", textFieldFirma.text, textFieldModel.text, textFieldMaxSpeed.text.integerValue, textFieldSlots.text.integerValue, wifi.on]];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldFirma.text isEqualToString:@""]){
        [str appendString:@"Введите фирму производителя\n"];
    }
    
    if([textFieldModel.text isEqualToString:@""]){
        [str appendString:@"Введите модель изделия\n"];
    }
    
    if([textFieldMaxSpeed.text isEqualToString:@""]){
        [str appendString:@"Введите максимальную скорость\n"];
    }
    
    if([ textFieldSlots.text isEqualToString:@""]){
        [str appendString:@"Введите количество слотов\n"];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
