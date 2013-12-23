//
//  AppInfoVC.m
//  BDEfanov
//
//  Created by Ефанов Сергей on 15.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "AppInfoVC.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface AppInfoVC (){
    NSArray *arr;
    NSString *str;
}

@end

@implementation AppInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([str isEqualToString:MY_SEO])
        return 3;
    
    return arr.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier: @"ABC"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ABC"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.font = [UIFont boldSystemFontOfSize: 14];
    }
    
    NSMutableString *label = [NSMutableString new];
    
    if([str isEqualToString:MY_APPLICATION]){
        [label appendString:@"Заявка № "];
        [label appendString:[arr[indexPath.row] valueForKey:@"numberApplication"]];
        [label appendString:@" выполнена.                    Подпись сотрудника  _________________"];
    }
    
    if([str isEqualToString:MY_WORKER]){
        [label appendString:[arr[indexPath.row] valueForKey:@"fioWorker"]];
        [label appendString:@" \t\t"];
        [label appendString:[arr[indexPath.row] valueForKey:@"cost"]];
    }
    
    static NSInteger sumIn, sumOut, sumAll;
    NSArray *mySummArr;
    
    if([str isEqualToString:MY_SEO]){
        switch (indexPath.row) {
            case 0:
                [label appendString:@"Доход компании: "];
                
                mySummArr = [SQLiteAccess selectManyRowsWithSQL:@"select * from Contract"];
                sumIn = 0;
                
                for(NSDictionary *dict in mySummArr){
                    sumIn += ((NSString*)[dict valueForKey:@"summCost"]).integerValue;
                }
                [label appendFormat:@"%d руб.", sumIn];
                
                break;
            case 1:
                [label appendString:@"Расход компании: "];
                
                mySummArr = [SQLiteAccess selectManyRowsWithSQL:@"select * from Worker"];
                sumOut = 0;
                for(NSDictionary *dict in mySummArr){
                    sumOut += ((NSString*)[dict valueForKey:@"summCost"]).integerValue;
                }
                [label appendFormat:@"%d руб.", sumOut];
                
                break;
            case 2:
                
                sumAll = sumIn - sumOut;
                
                [label appendString:@"Всего: "];
                [label appendFormat:@"%d руб.", sumAll];
                
                break;
            default:
                break;
        }
    }
    
    cell.textLabel.text = label;
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myTable.userInteractionEnabled = NO;
    myImage.image = [UIImage imageNamed:@"fastbit.gif"];
    
    str = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).entity;
    
    if([str isEqualToString:MY_APPLICATION]){
        arr = [SQLiteAccess selectManyRowsWithSQL:@"select * from Application where closed = 1"];
        myTitle.text = @"Отчет о работе технической поддержки";
        myWorker.text = @"Руководитель тех. поддержки";
    }
    
    if([str isEqualToString:MY_WORKER]){
        arr = [SQLiteAccess selectManyRowsWithSQL:@"select * from Worker where cost > 5000"];
        myTitle.text = @"Отчет о заработной плате сотрудников";
        myWorker.text = @"Директор";
    }
    
    if([str isEqualToString:MY_SEO]){
        myTitle.text = @"Отчет о доходах компании";
        myWorker.text = @"Директор";
        myTitleCount.hidden = YES;
        myCount.hidden = YES;
    }
    
    myCount.text = [NSString stringWithFormat:@"%d", arr.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
