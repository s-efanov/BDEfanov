//
//  DetailViewController.m
//  Kurs
//
//  Created by Sergey Efanov on 02.12.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import "AppDelegate.h"
#import "NewBaseVC.h"
#import "DetailViewController.h"
#import "Constants.h"
#import "EnterVC.h"

#import "Office.h"
#import "Contract.h"
#import "Tarifs.h"
#import "Worker.h"
#import "Dolz.h"
#import "Service.h"
#import "Application.h"
#import "Equipment.h"
#import "Client.h"

@interface DetailViewController (){
    UIPopoverController *popover;
    NSManagedObjectContext *managedObjectContext;
    NSString *myEntity;
    NSString *sort;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [myTable reloadData];
}

-(IBAction)btnExit:(id)sender{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"                                                 bundle: nil];
    
    EnterVC *enterVC = (EnterVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"enterVC"];
    window.rootViewController = enterVC;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier: @"ABC"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ABC"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.font = [UIFont boldSystemFontOfSize: 14];
    }
    
    NSString *str = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).entity;
    NSString *labelForRow;
    
    if([str isEqualToString:MY_OFFICE]){
        Office *office = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = office.name;
    }
    
    if([str isEqualToString:MY_SERVICE]){
        Service *service = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = service.name;
    }
    
    if([str isEqualToString:MY_TARIFF]){
        Tarifs *tarifs = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = tarifs.name;
    }
    
    if([str isEqualToString:MY_EQUIPMENT]){
        Equipment *equipment = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = equipment.model;
    }
    
    if([str isEqualToString:MY_CLIENT]){
        Client *client = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = client.lastName;
    }
    
    if([str isEqualToString:MY_WORKER]){
        Worker *worker = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = worker.name;
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        Application *application = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = application.idApplication.stringValue;
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        Contract *contract = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = contract.idContract.stringValue;
    }
    
    if([str isEqualToString:MY_DOLZ]){
        Dolz *dolz = [self.fetchedResultsController fetchedObjects][indexPath.row];
        labelForRow = dolz.nameDolz;
    }
    
    cell.textLabel.text = labelForRow;
    
    return cell;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    NSString *str = [[_fetchedResultsController fetchRequest] entityName];
    if (_fetchedResultsController != nil && [str isEqualToString:myEntity]) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:myEntity inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sort ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:myEntity];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

-(void) closePopover{
    [popover dismissPopoverAnimated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(IBAction)btnNew:(id)sender{
    NSString *str = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).entity;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     NewBaseVC *viewContr;
    
    if([str isEqualToString:MY_OFFICE]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newOffice"];
    }
    
    if([str isEqualToString:MY_SERVICE]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newService"];
    }
    
    if([str isEqualToString:MY_TARIFF]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newTariff"];
    }
    
    if([str isEqualToString:MY_EQUIPMENT]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newEquipment"];
    }
    
    if([str isEqualToString:MY_CLIENT]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newClient"];
    }
    
    if([str isEqualToString:MY_WORKER]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newWorker"];
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newApplication"];
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newContract"];
    }
    
    if([str isEqualToString:MY_DOLZ]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newDolz"];
    }
    
    viewContr.delegate = self;
    viewContr.fetchedResultsController = self.fetchedResultsController;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewContr];
    popover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    popover.delegate = self;
    [popover presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections: UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionUp animated:YES];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.fetchedResultsController fetchedObjects] count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)configureView
{
    NSString *str = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).entity;
    self.navigationItem.title = str;
    
    if([str isEqualToString:MY_OFFICE]){
        myEntity = TABLE_OFFICE;
        btn.titleLabel.text = @"Новый офис";
        sort = @"name";
    }

    if([str isEqualToString:MY_SERVICE]){
        myEntity = TABLE_SERVICE;
        btn.titleLabel.text = @"Новая услуга";
        sort = @"name";
    }
    
    if([str isEqualToString:MY_TARIFF]){
        myEntity = TABLE_TARIFF;
        btn.titleLabel.text = @"Новый тариф";
        sort = @"name";
    }

    if([str isEqualToString:MY_EQUIPMENT]){
        myEntity = TABLE_EQUIPMENT;
        btn.titleLabel.text = @"Новое оборудование";
        sort = @"model";
    }
    
    if([str isEqualToString:MY_CLIENT]){
        myEntity = TABLE_CLIENT;
        btn.titleLabel.text = @"Новый клиент";
        sort = @"name";
    }
    
    if([str isEqualToString:MY_WORKER]){
        myEntity = TABLE_WORKER;
        btn.titleLabel.text = @"Новый сотрудник";
        sort = @"name";
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        myEntity = TABLE_APPLICATION;
        btn.titleLabel.text = @"Новая заявка";
        sort = @"descriptioncontract";
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        myEntity = TABLE_CONTRACT;
        btn.titleLabel.text = @"Новый договор";
        sort = @"idContract";
    }
    
    if([str isEqualToString:MY_DOLZ]){
        myEntity = TABLE_DOLZ;
        btn.titleLabel.text = @"Новая должность";
        sort = @"idDolz";
    }
    
    [myTable reloadData];
    
    //if (self.detailItem) {
    //    self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    //}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    managedObjectContext = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
