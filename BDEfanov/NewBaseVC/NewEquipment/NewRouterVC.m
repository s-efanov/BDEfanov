//
//  NewRouterVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewRouterVC.h"

@implementation NewRouterVC{
    NSArray *modeles;
    
    NSString *oldFirma;
    NSString *myFirma;
    NSString *oldModel;
    NSString *myModel;
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
    modeles = [SQLiteAccess selectManyRowsWithSQL:@"select * from Model"];
    
    if(self.object){
        oldModel = [self.object valueForKey:@"model"];
        myModel = oldModel;
        oldFirma = [self.object valueForKey:@"firma"];
        myFirma = oldFirma;
        
        NSInteger index = 0;
        
        for(NSDictionary *dict in modeles){
            if([[dict valueForKey:@"firma"] isEqualToString:oldFirma] && [[dict valueForKey:@"model"] isEqualToString:oldModel])
                break;
            index++;
        }
        
        [pickerRouter selectRow: index inComponent:0 animated:YES];
        return;
    }
    
    if(modeles.count){
        [pickerRouter selectRow:0 inComponent:0 animated:YES];
        oldFirma = [modeles[0] valueForKey:@"firma"];
        myFirma = oldFirma;
        oldModel = [modeles[0] valueForKey:@"model"];
        myModel = oldModel;
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
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Router set model = '%@', firma = '%@' where numberRouter = %d", myModel, myFirma, ((NSString*)[self.object valueForKey:@"numberRouter"]).integerValue]];
    else
        [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"insert into Router (firma, model) values ('%@', '%@')", myFirma, myModel]];
    
    [self.delegate closePopover];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return modeles.count;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    myFirma = [modeles[row] valueForKey:@"firma"];
    myModel = [modeles[row] valueForKey:@"model"];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSMutableString *str = [NSMutableString new];
    [str appendString:[modeles[row] valueForKey:@"firma"]];
    [str appendString:@" "];
    [str appendString:[modeles[row] valueForKey:@"model"]];
    return str;
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if(!modeles.count){
        [str appendString:@"Нет роутеров\n"];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
