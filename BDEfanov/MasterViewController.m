//
//  MasterViewController.m
//  Kurs
//
//  Created by Sergey Efanov on 02.12.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface MasterViewController (){
    NSArray *fields;
}
    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    //self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDictionary];

    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).entity = fields[0];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

-(void) initDictionary{
    NSArray *admin = @[MY_OFFICE, MY_TARIF, MY_SERVICE, MY_DOLZ, MY_GRAPH, MY_WORKER, MY_ROUTER, MY_MODEL, MY_APPLICATION, MY_CONTRACT, MY_SEO];
    NSArray *callWorker = @[MY_CONTRACT, MY_APPLICATION];
    NSArray *techWorker = @[MY_APPLICATION];
    NSArray *cadrWorker = @[MY_WORKER];
    NSArray *officeWorker = @[MY_CONTRACT];
    
    NSDictionary *dictUsers = [NSDictionary dictionaryWithObjectsAndKeys:admin, @"admin", callWorker, @"callWorker", techWorker, @"techWorker", officeWorker, @"officeWorker", cadrWorker, @"cadrWorker", nil];
    
    fields = [dictUsers objectForKey:((AppDelegate *)[[UIApplication sharedApplication] delegate]).user];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).entity = fields[indexPath.row];
    [self.detailViewController configureView];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = fields[indexPath.row];
}

@end
