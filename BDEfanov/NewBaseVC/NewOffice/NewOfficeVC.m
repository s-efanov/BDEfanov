//
//  NewOfficeVC.m
//  KursovayaBD
//
//  Created by Sergey Efanov on 28.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "NewOfficeVC.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface NewOfficeVC (){

}

@end

@implementation NewOfficeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.object){
        textFieldNameOffice.text = [self.object valueForKey:@"nameOffice"];
        textFieldAdress.text = [self.object valueForKey:@"adress"];
        textFieldInfo.text = [self.object valueForKey:@"info"];
        textFieldTel.text = [self.object valueForKey:@"tel"];
        
        textFieldNameOffice.userInteractionEnabled = NO;
        textFieldNameOffice.backgroundColor = [UIColor lightGrayColor];
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
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Office set tel = %d, adress = '%@', info = '%@' where nameOffice = '%@'", textFieldTel.text.integerValue, textFieldAdress.text, textFieldInfo.text, textFieldNameOffice.text]];
    else
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"insert into Office (tel, adress, info, nameOffice) values (%d, '%@', '%@', '%@')", textFieldTel.text.integerValue, textFieldInfo.text, textFieldAdress.text, textFieldNameOffice.text]];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldNameOffice.text isEqualToString:@""]){
        [str appendString:@"Название офиса не может быть пустым\n"];
    }
    
    if([textFieldAdress.text isEqualToString:@""]){
        [str appendString:@"Адрес офиса не может быть пустым\n"];
    }
    
    if([textFieldTel.text isEqualToString:@""]){
        [str appendString:@"Введите номер телефона\n"];
    }
    
    if([textFieldInfo.text isEqualToString:@""]){
        [str appendString:@"Информация не может быть пустой\n"];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
