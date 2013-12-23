//
//  NewWorkerVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewWorkerVC.h"

@interface NewWorkerVC (){
    NSArray *dolzs;
    NSArray *offices;
    NSString *nameDolz;
    NSString *nameOffice;
    NSString *oldOffice;
    NSString *oldDolz;
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
    
    dolzs = [SQLiteAccess selectManyRowsWithSQL:@"select * from Dolz"];
    offices = [SQLiteAccess selectManyRowsWithSQL:@"select * from Office"];
    
    if(self.object){
        textFieldFIO.userInteractionEnabled = NO;
        textFieldFIO.backgroundColor = [UIColor lightGrayColor];
        textFieldPasseport.backgroundColor = [UIColor lightGrayColor];
        textFieldPasseport.userInteractionEnabled = NO;
        
        textFieldIndex.text = [self.object valueForKey:@"indexCost"];
        
        oldDolz = [self.object valueForKey:@"nameDolz"];
        oldOffice = [self.object valueForKey:@"nameOffice"];
        
        nameOffice = oldOffice;
        nameDolz = oldDolz;
        
        textFieldFIO.text = [self.object valueForKey:@"fioWorker"];
        textFieldPasseport.text = [self.object valueForKey:@"numberPasseport"];
        textFieldAdress.text = [self.object valueForKey:@"adress"];
        textFieldTel.text = [self.object valueForKey:@"tel"];
        switchMed.on = ((NSString*)[self.object valueForKey:@"med"]).integerValue;
        
        textFieldCost.text = [self.object valueForKey:@"cost"];
        
        
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"dd.MM.yyyy"];
        NSDate *date = [dateFormat dateFromString:[self.object valueForKey:@"birthDate"]];
        [pickerDateBirth setDate:date];
        
        //устанавливаем офис в пикер
        NSInteger index = 0;
        
        for(NSDictionary *dict in offices){
            if([[dict valueForKey:@"nameOffice"] isEqualToString:oldOffice])
                break;
            index++;
        }
        
        [pickerOffice selectRow:index inComponent:0 animated:YES];
        
        //устанавливаем должность в пикер
        index = 0;
        
        for(NSDictionary *dict in dolzs){
            if([[dict valueForKey:@"nameDolz"] isEqualToString:oldDolz])
                break;
            index++;
        }
        [pickerDolz selectRow:index inComponent:0 animated:YES];
        return;
    }
    
    
    if(dolzs.count){
        switchMed.on = NO;
        [pickerDolz selectRow:0 inComponent:0 animated:YES];
        nameDolz = [dolzs[0] valueForKey:@"nameDolz"];
    }
}

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    NSString *myDate = [dateFormat stringFromDate:pickerDateBirth.date];

    if(self.object)
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Worker set birthDate = '%@', nameDolz = '%@', nameOffice = '%@', med = %d, cost = %d, adress = '%@', tel = %d, indexCost = %d where fioWorker = '%@' and numberPasseport =  %d", myDate, nameDolz, nameOffice, switchMed.on, textFieldCost.text.integerValue, textFieldAdress.text, textFieldTel.text.integerValue, textFieldIndex.text.integerValue, textFieldFIO.text, textFieldPasseport.text.integerValue]];
    else
        [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"insert into Worker (birthDate, nameDolz, nameOffice, med, cost, adress, tel, fioWorker, numberPasseport, indexCost) values ('%@', '%@', '%@', %d, %d, '%@', %d, '%@', %d, %d)", myDate, nameDolz, nameOffice, switchMed.on, textFieldCost.text.integerValue, textFieldAdress.text, textFieldTel.text.integerValue, textFieldFIO.text, textFieldPasseport.text.integerValue, textFieldIndex.text.integerValue]];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldFIO.text isEqualToString:@""]){
        [str appendString:@"Введите ФИО\n"];
    }
    
    if([textFieldCost.text isEqualToString:@""]){
        [str appendString:@"Введите оклад\n"];
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
    
    if(!offices.count){
        [str appendString:@"Нет офисов\n"];
    }
    
    return str;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView.tag == 0)
        return dolzs.count;
    
    if(pickerView.tag == 1)
        return offices.count;
    
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 0)
        return [dolzs[row] valueForKey:@"nameDolz"];
    
    if(pickerView.tag == 1)
        return [offices[row] valueForKey:@"nameOffice"];
    
    return nil;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag == 0)
        nameDolz = [dolzs[row] valueForKey: @"nameDolz"];
    
    if(pickerView.tag == 1)
        nameOffice = [offices[row] valueForKey:@"nameOffice"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
