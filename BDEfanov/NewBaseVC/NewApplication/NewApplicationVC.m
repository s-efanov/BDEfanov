//
//  NewApplicationVC.m
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewApplicationVC.h"

@interface NewApplicationVC (){
    NSArray *contracts;
    
    NSString *oldContract;
    NSString *myContract;
}

@end

@implementation NewApplicationVC

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
    
	contracts = [SQLiteAccess selectManyRowsWithSQL:@"select * from Contract"];
    
    if(self.object){
        oldContract = [self.object valueForKey:@"numberContract"];
        myContract = oldContract;
        textFieldDescription.text = [self.object valueForKey:@"description"];
        switchClosed.on = ((NSString*)[self.object valueForKey:@"closed"]).boolValue;
        
        NSInteger index = 0;
        
        for(NSDictionary *dict in contracts){
            if([[dict valueForKey:@"numberContract"] isEqualToString:oldContract])
                break;
            index++;
        }
        
        [pickerContract selectRow: index inComponent:0 animated:YES];
        return;
    }
    
    switchClosed.on = NO;
    
    if(contracts.count){
        [pickerContract selectRow:0 inComponent:0 animated:YES];
        oldContract = [contracts[0] valueForKey:@"numberContract"];
        myContract = oldContract;
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
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Application set numberContract = %d, description = '%@', closed = %d where numberApplication = %d", myContract.integerValue, textFieldDescription.text, switchClosed.on, ((NSString*)[self.object valueForKey:@"numberApplication"]).integerValue]];
    else
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"insert into Application (numberContract, description, closed) values (%d, '%@', %d)", myContract.integerValue, textFieldDescription.text, switchClosed.on]];

    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldDescription.text isEqualToString:@""]){
        [str appendString:@"Описание не может быть пустым\n"];
    }
    
    if(!contracts.count){
        [str appendString:@"В приложении нет договоров\n"];
    }
    
    return str;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return contracts.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [contracts[row] valueForKey:@"numberContract"];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    myContract = [contracts[row] valueForKey:@"numberContract"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
