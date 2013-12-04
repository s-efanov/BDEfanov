//
//  NewBaseVC.m
//  KursovayaBD
//
//  Created by Sergey Efanov on 30.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "NewBaseVC.h"
#import "DetailViewController.h"

@interface NewBaseVC ()

@end

@implementation NewBaseVC
@synthesize delegate;

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
	// Do any additional setup after loading the view.
}

-(IBAction)btnCancel:(id)sender{
    [delegate closePopover];
}

-(IBAction)btnSave:(id)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
