//
//  NewContractVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewContractVC.h"
#import "Equipment.h"
#import "Client.h"
#import "Tarifs.h"
#import "Office.h"
#import "Worker.h"
#import "Service.h"
#import "Limits.h"
#import "Contract.h"

@interface NewContractVC (){
    NSArray *equipments;
    NSArray *clients;
    NSArray *tarifs;
    NSArray *offices;
    NSArray *workers;
    NSArray *services;
    Limits *limits;
    
    NSString *serviceName;
    NSString *workerName;
    NSString *nameOffice;
    NSString *tarifName;
    NSString *equipmentModel;
    NSString *clientName;
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
    equipments = [Equipment MR_findAll];
    clients = [Client MR_findAll];
    tarifs = [Tarifs MR_findAll];
    offices = [Office MR_findAll];
    workers = [Worker MR_findAll];
    services = [Service MR_findAll];
    limits = [Limits MR_findAll][0];
    
    if(equipments.count)
        equipmentModel = ((Equipment*)equipments[0]).model;
    
    if(clients.count)
        clientName = ((Client*)clients[0]).name;
    
    if(services.count)
        serviceName = ((Service*)services[0]).name;
    
    if(offices.count)
        nameOffice = ((Office*)offices[0]).name;
    
    if(workers.count)
        workerName = ((Worker*)workers[0]).name;
    
    if(tarifs.count)
        tarifName = ((Tarifs*)tarifs[0]).name;
}

-(IBAction)btnSave:(id)sender{
    
    NSString *str = [self validate];
    
    if(![str isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:str delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    
    if(!self.object){
        self.object = [Contract MR_createEntity];
        ((Contract*)self.object).idContract = [limits nextContractId];
    }
    
    //Заполняем id клиента
    NSPredicate *clientPredicate = [NSPredicate predicateWithFormat:@"name = %@", clientName];
    NSArray *myClient = [Client MR_findAllWithPredicate:clientPredicate];
    ((Contract*)self.object).parentClient = myClient[0];
    
    //заполняем id роутера
    NSPredicate *equipmentPredicate = [NSPredicate predicateWithFormat:@"model = %@", equipmentModel];
    NSArray *myEquipment = [Equipment MR_findAllWithPredicate:equipmentPredicate];
    ((Contract*)self.object).parentEquipment = myEquipment[0];
    
    //заполняем id офиса
    NSPredicate *officePredicate = [NSPredicate predicateWithFormat:@"name = %@", nameOffice];
    NSArray *myOffice = [Office MR_findAllWithPredicate:officePredicate];
    ((Contract*)self.object).parentOffice = myOffice[0];
    
    //заполняем id тарифа
    NSPredicate *tarifPredicate = [NSPredicate predicateWithFormat:@"name = %@", tarifName];
    NSArray *myTarif = [Tarifs MR_findAllWithPredicate:tarifPredicate];
    ((Contract*)self.object).parentTarif = myTarif[0];
    
    //заполняем id работника
    NSPredicate *workerPredicate = [NSPredicate predicateWithFormat:@"name = %@", workerName];
    NSArray *myWorker = [Worker MR_findAllWithPredicate:workerPredicate];
    ((Contract*)self.object).parentWorker = myWorker[0];
    
    //заполняем id услуги
    NSPredicate *servicePredicate = [NSPredicate predicateWithFormat:@"name = %@", serviceName];
    NSArray *myService = [Service MR_findAllWithPredicate:servicePredicate];
    [((Contract*)self.object) addParentServiceObject: myService[0]];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if(!equipments.count){
        [str appendString:@"Нет роутеров на складе\n"];
    }
    
    if(!clients.count){
        [str appendString:@"Нет клиентов\n"];
    }
    
    if(!tarifs.count){
        [str appendString:@"Нет тарифов\n"];
    }
    
    if(!offices.count){
        [str appendString:@"Нет офисов\n"];
    }
    
    if(!workers.count){
        [str appendString:@"Нет сотрудников\n"];
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
            return equipments.count;
            break;
        case 2:
            return clients.count;
            break;
        case 3:
            return offices.count;
            break;
        case 4:
            return workers.count;
            break;
        case 5:
            return services.count;
        default:
            return 0;
            break;
    }
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch(pickerView.tag){
        case 0:
            return ((Tarifs*)tarifs[row]).name;
            break;
        case 1:
            return ((Equipment*)equipments[row]).model;
            break;
        case 2:
            return ((Client*)clients[row]).name;
            break;
        case 3:
            return ((Office*)offices[row]).name;
            break;
        case 4:
            return ((Worker*)workers[row]).name;
            break;
        case 5:
            return ((Service*)services[row]).name;
        default:
            return 0;
            break;
    }
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch(pickerView.tag){
        case 0:
            tarifName = ((Tarifs*)tarifs[row]).name;
            break;
        case 1:
            equipmentModel = ((Equipment*)equipments[row]).model;
            break;
        case 2:
            clientName = ((Client*)clients[row]).name;
            break;
        case 3:
            nameOffice = ((Office*)offices[row]).name;
            break;
        case 4:
            workerName = ((Worker*)workers[row]).name;
            break;
        case 5:
            serviceName = ((Service*)services[row]).name;
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
