//
//  AppInfoVC.m
//  BDEfanov
//
//  Created by Ефанов Сергей on 15.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "AppInfoVC.h"
#import "Application.h"
#import "Worker.h"
#import "Dolz.h"
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
        [label appendString:((Application*)arr[indexPath.row]).idApplication.stringValue];
        [label appendString:@" выполнена.                    Роспись сотрудника  _________________"];
    }
    
    if([str isEqualToString:MY_WORKER]){
        [label appendString:@"Сотрудник "];
        [label appendString:((Worker*)arr[indexPath.row]).lastname];
        [label appendString:@" "];
        [label appendString:((Worker*)arr[indexPath.row]).name];
        [label appendString:@" "];
        [label appendString:((Worker*)arr[indexPath.row]).otec];
        [label appendString:@" получает "];
        [label appendString:((Worker*)arr[indexPath.row]).parentDolz.cost.stringValue];
        [label appendString:@" руб."];
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
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"closed = YES"];
        arr = [Application MR_findAllWithPredicate:predicate];
        myTitle.text = @"Отчет о выполнении заявок";
        myWorker.text = @"Руководитель тех. поддержки";
    }
    
    if([str isEqualToString:MY_WORKER]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentDolz.cost > 20000"];
        arr = [Worker MR_findAllWithPredicate:predicate];
        myTitle.text = @"Отчет о заработной плате";
        myWorker.text = @"Директор";
    }
    
    myCount.text = [NSString stringWithFormat:@"%d", arr.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
