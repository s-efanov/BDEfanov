//
//  NewGraph.m
//  BDEfanov
//
//  Created by Ефанов Сергей on 22.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "NewGraph.h"

@interface NewGraph ()

@end

@implementation NewGraph

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
        textFieldNameGraph.text = [self.object valueForKey:@"graph"];
        textFieldClock.text = [self.object valueForKey:@"clock"];
        
        textFieldNameGraph.userInteractionEnabled = NO;
        textFieldNameGraph.backgroundColor = [UIColor lightGrayColor];
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
        [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"update Graph set clock = '%@' where graph = '%@'", textFieldClock.text, textFieldNameGraph.text]];
    else
        [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"insert into Graph (graph, clock) values ('%@', '%@')", textFieldNameGraph.text, textFieldClock.text]];
    
    [self.delegate closePopover];
}

-(NSString*) validate{
    NSMutableString *str = [NSMutableString new];
    
    if([textFieldNameGraph.text isEqualToString:@""]){
        [str appendString:@"Введите наименование графика работы\n"];
    }
    
    if([textFieldClock.text isEqualToString:@""]){
        [str appendString:@"Введите часы работы\n"];
    }
    
    return str;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
