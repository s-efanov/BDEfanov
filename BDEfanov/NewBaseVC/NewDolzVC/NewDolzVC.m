//
//  NewDolzVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewDolzVC.h"

@implementation NewDolzVC{
    NSArray *graphics;
    NSString *oldGraphic;
    NSString *graphic;
    NSString *oldDolz;
    NSString *oldObligations;
}

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
	graphics = [SQLiteAccess selectManyRowsWithSQL:@"select * from Graph"];
    
    if(self.object){
        textFieldName.text = [self.object valueForKey:@"nameDolz"];
        textFieldName.userInteractionEnabled = NO;
        textFieldName.backgroundColor = [UIColor lightGrayColor];
        oldDolz = textFieldName.text;
        
        //устанавливаем график работы в пикер вью
        oldGraphic = [self.object valueForKey:@"graph"];
        graphic = oldGraphic;
        NSInteger index = 0;
        
        for(NSDictionary *dict in graphics){
            if([[dict valueForKey:@"graph"] isEqualToString:oldGraphic])
                break;
            index++;
        }
        
        [pickerGraph selectRow: index inComponent:0 animated:YES];
        
        //устанавливаем обязанности сотрудников
        NSArray *obligations = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select obligation from ObligationWorker where nameDolz = '%@'", textFieldName.text]];
        
        NSMutableString *obligation = [NSMutableString new];
        
        for (NSDictionary *dict in obligations){
            [obligation appendString:[dict valueForKey:@"obligation"]];
            [obligation appendString:@"; "];
        }
        
        if(obligation.length)
            [obligation deleteCharactersInRange:NSMakeRange(obligation.length - 2, 2)];
        
        textFieldWork.text = obligation;
        oldObligations = obligation;
        return;
    }
    
    if(graphics.count){
        [pickerGraph selectRow:0 inComponent:0 animated:YES];
        oldGraphic = [graphics[0] valueForKey:@"graph"];
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
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Dolz set graph = '%@' where nameDolz = '%@'", graphic, oldDolz]];
    else
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"insert into Dolz (nameDolz, graph) values ('%@', '%@')", textFieldName.text, graphic]];
    
    [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from ObligationWorker where nameDolz = '%@'", oldDolz]];
    
    NSArray *arr = [textFieldWork.text componentsSeparatedByString:@"; "];
    
    for(NSString *str in arr){
        if(![str isEqualToString:@""])
            [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"insert into ObligationWorker (nameDolz, obligation) values ('%@', '%@')", textFieldName.text, str]];
    }
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldName.text isEqualToString:@""]){
        [str appendString:@"Название должности не может быть пустым\n"];
    }
    
    if([textFieldWork.text isEqualToString:@""]){
        [str appendString:@"Обязанности не могут быть пустыми\n"];
    }
    
    if(!graphics.count){
        [str appendString:@"Не выбран график работы\n"];
    }
    
    return str;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return graphics.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [graphics[row] valueForKey:@"graph"];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   graphic = [graphics[row] valueForKey:@"graph"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
