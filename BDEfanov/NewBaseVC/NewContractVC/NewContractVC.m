//
//  NewContractVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewContractVC.h"

@interface NewContractVC (){
    NSArray *tarifs;
    NSArray *offices;
    NSArray *services;
    NSArray *routers;
    NSMutableArray *enableServices;
    
    NSString *nameOffice;
    NSString *nameTarif;
    NSString *oldOffice;
    NSString *oldTarif;
    NSString *oldRouter;
    NSString *myRouter;
}

@end

@implementation NewContractVC

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
    enableServices = [NSMutableArray new];
    routers = [SQLiteAccess selectManyRowsWithSQL:@"select * from Router"];
    tarifs = [SQLiteAccess selectManyRowsWithSQL:@"select * from Tarif"];
    offices = [SQLiteAccess selectManyRowsWithSQL:@"select * from Office"];
    services = [SQLiteAccess selectManyRowsWithSQL:@"select * from Service"];
    
    if(self.object){
        oldTarif = [self.object valueForKey:@"nameTarif"];
        oldOffice = [self.object valueForKey:@"nameOffice"];
        oldRouter = [self.object valueForKey:@"numberRouter"];
        
        myRouter = oldRouter;
        nameOffice = oldOffice;
        nameTarif = oldTarif;
        
        textFieldFIOClient.text = [self.object valueForKey:@"fioClient"];
        textFieldAdress.text = [self.object valueForKey:@"adress"];
        textFieldIndex.text = [self.object valueForKey:@"sales"];
        
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"dd.MM.yyyy"];
        NSDate *date = [dateFormat dateFromString:[self.object valueForKey:@"birthClient"]];
        [datePickerClientBirth setDate:date];
        
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
        
        for(NSDictionary *dict in tarifs){
            if([[dict valueForKey:@"nameTarif"] isEqualToString:oldTarif])
                break;
            index++;
        }
        [pickerTarif selectRow:index inComponent:0 animated:YES];
        
        index = 0;
        
        for(NSDictionary *dict in routers){
            if([[dict valueForKey:@"numberRouter"] isEqualToString:oldRouter])
                break;
            index++;
        }
        [pickerNumberRouter selectRow:index inComponent:0 animated:YES];
        
        //заполняем услуги
        index = 0;
        
        NSArray *myServices = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from ContractService where numberContract = %d", ((NSString*)[self.object valueForKey:@"numberContract"]).integerValue]];
        
        for (NSDictionary *dict in services){
            [enableServices addObject:[NSNumber numberWithInteger:0]];
            for(NSDictionary *dictMyService in myServices){
                if([((NSString*)[dict objectForKey:@"nameService"]) isEqualToString:[dictMyService objectForKey:@"nameService"]])
                    enableServices[index] = [NSNumber numberWithInteger:1];
            }
            index++;
        }
        
        return;
    }
    
    if(offices.count){
        [pickerOffice selectRow:0 inComponent:0 animated:YES];
        nameOffice = [offices[0] valueForKey:@"nameOffice"];
    }
    
    if(tarifs.count){
        [pickerTarif selectRow:0 inComponent:0 animated:YES];
        nameTarif = [offices[0] valueForKey:@"nameTarif"];
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return services.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier: @"ABC"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ABC"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.font = [UIFont boldSystemFontOfSize: 14];
    }
    
    if(self.object && ((NSNumber*)enableServices[indexPath.row]).integerValue){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = [services[indexPath.row] valueForKey:@"nameService"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        enableServices[indexPath.row] = [NSNumber numberWithInteger:0];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        enableServices[indexPath.row] = [NSNumber numberWithInteger:1];
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
    NSString *myDate = [dateFormat stringFromDate:datePickerClientBirth.date];
    
    if(self.object)
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Contract set nameTarif = '%@', fioClient = '%@', birthClient = '%@', adress = '%@', nameOffice = '%@', sales = %d, numberRouter = %d where numberContract = %d", nameTarif, textFieldFIOClient.text, myDate, textFieldAdress.text, nameOffice, textFieldIndex.text.integerValue, myRouter.integerValue, ((NSString*)[self.object valueForKey:@"numberContract"]).integerValue]];
    else
        [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"insert into Contract (nameTarif, fioClient, birthClient, adress, nameOffice, sales, numberRouter) values ('%@', '%@', '%@', '%@', '%@', %d, %d)", nameTarif, textFieldFIOClient.text, myDate, textFieldAdress.text, nameOffice, textFieldIndex.text.integerValue, myRouter.integerValue]];
    
    [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from ContractService where numberContract = %d", ((NSString*)[self.object valueForKey:@"numberContract"]).integerValue]];
    
    NSInteger i = 0;
    
    for(NSNumber *enable in enableServices){
        if(enable.integerValue)
            [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"insert into ContractService (nameService, numberContract) values ('%@', %d)", [services[i] valueForKey:@"nameService"], ((NSString*)[self.object valueForKey:@"numberContract"]).integerValue]];
        i++;
    }
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldFIOClient.text isEqualToString:@""]){
        [str appendString:@"Введите ФИО клиента\n"];
    }
    
    if([textFieldAdress.text isEqualToString:@""]){
        [str appendString:@"Введите адрес подключения\n"];
    }
    
    if(!tarifs.count){
        [str appendString:@"Нет тарифов\n"];
    }
    
    if(!offices.count){
        [str appendString:@"Нет офисов\n"];
    }
    
    if(!services.count){
        [str appendString:@"Нет услуг\n"];
    }
    
    return str;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch(pickerView.tag){
        case 0:
            return tarifs.count;
            break;
        case 1:
            return offices.count;
            break;
        case 2:
            return routers.count;
        default:
            return 0;
    }
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch(pickerView.tag){
        case 0:
            return [tarifs[row] valueForKey:@"nameTarif"];
            break;
        case 1:
            return [offices[row] valueForKey:@"nameOffice"];
            break;
        case 2:
            return [routers[row] valueForKey:@"numberRouter"];
        default:
            return 0;
    }
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch(pickerView.tag){
        case 0:
            nameTarif = [tarifs[row] valueForKey:@"nameTarif"];
            break;
        case 1:
            nameOffice = [offices[row] valueForKey:@"nameOffice"];
            break;
        case 2:
            myRouter = [routers[row] valueForKey:@"numberRouter"];
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
