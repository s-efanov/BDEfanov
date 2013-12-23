//
//  NewServiceVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewServiceVC.h"

@interface NewServiceVC (){

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
    
    if(self.object){
        textFieldCost.text = [self.object valueForKey:@"costService"];
        textFieldName.text = [self.object valueForKey:@"nameService"];
        
        textFieldName.userInteractionEnabled = NO;
        textFieldName.backgroundColor = [UIColor lightGrayColor];
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
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Service set costService = %d where nameService = '%@'", textFieldCost.text.integerValue, textFieldName.text]];
    else
        [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"insert into Service (nameService, costService) values ('%@', %d)", textFieldName.text, textFieldCost.text.integerValue]];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldCost.text isEqualToString:@""]){
        [str appendString:@"Стоимость не может быть пустой\n"];
    }
    
    if([textFieldName.text isEqualToString:@""]){
        [str appendString:@"Наименование услуги не может быть пустым\n"];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
