//
//  EnterVC.m
//  Kurs
//
//  Created by Sergey Efanov on 02.12.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "EnterVC.h"
#import "AppDelegate.h"

@interface EnterVC (){
    NSArray *users;
    NSArray *customer;
}
@end

@implementation EnterVC

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
    customer = @[@"Директор", @"Сотрудник Call-ценра", @"Тех. поддержка", @"Сотрудник офиса", @"Отдел кадров"];
    users = @[@"admin", @"callWorker", @"techWorker", @"officeWorker", @"cadrWorker"];
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).user = users[0];
	// Do any additional setup after loading the view.
}

-(IBAction)enter:(id)sender{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"                                                           bundle: nil];
    
    UISplitViewController *splitView = (UISplitViewController*)[mainStoryboard
                                                          instantiateViewControllerWithIdentifier: @"splitView"];
    
    UINavigationController *navigationController = [splitView.viewControllers lastObject];
    splitView.delegate = (id)navigationController.topViewController;
    
    window.rootViewController = splitView;
}


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return customer.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return customer[row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).user = users[row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
