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
#import "Limits.h"

@interface DetailViewController (){
    UIPopoverController *popover;
    NSManagedObjectContext *managedObjectContext;
    NSString *myEntity;
    NSString *str;
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
    
    NSMutableString *labelForRow = [NSMutableString new];
    
    if([str isEqualToString:MY_OFFICE]){
        Office *office = [Office MR_findAll][indexPath.row];
        [labelForRow appendString: office.name];
        [labelForRow appendString:@" "];
        [labelForRow appendString:office.adress];
    }
    
    if([str isEqualToString:MY_SERVICE]){
        Service *service = [Service MR_findAll][indexPath.row];
        [labelForRow appendString: service.name];
        [labelForRow appendString:@" "];
        [labelForRow appendString:service.cost.stringValue];
        [labelForRow appendString:@" руб."];
    }
    
    if([str isEqualToString:MY_TARIFF]){
        Tarifs *tarifs = [Tarifs MR_findAll][indexPath.row];
        [labelForRow appendString: tarifs.name];
        [labelForRow appendString:@" Скорость: "];
        [labelForRow appendString:tarifs.speed.stringValue];
        [labelForRow appendString:@" Мбит/с"];
    }
    
    if([str isEqualToString:MY_EQUIPMENT]){
        Equipment *equipment = [Equipment MR_findAll][indexPath.row];
        [labelForRow appendString: equipment.firm];
        [labelForRow appendString:@" "];
        [labelForRow appendString:equipment.model];
        [labelForRow appendString:@" "];
        [labelForRow appendString:equipment.scancode.stringValue];
    }
    
    if([str isEqualToString:MY_CLIENT]){
        Client *client = [Client MR_findAll][indexPath.row];
        [labelForRow appendString: client.lastName];
        [labelForRow appendString:@" "];
        [labelForRow appendString: client.name];
        [labelForRow appendString:@" "];
        [labelForRow appendString: client.otec];
    }
    
    if([str isEqualToString:MY_WORKER]){
        Worker *worker = [Worker MR_findAll][indexPath.row];
        [labelForRow appendString: worker.name];
        [labelForRow appendString:@" "];
        [labelForRow appendString:worker.lastname];
        [labelForRow appendString:@" "];
        [labelForRow appendString:worker.otec];
        [labelForRow appendString:@" "];
        
        [labelForRow appendString:worker.parentDolz.nameDolz];
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        Application *application = [Application MR_findAll][indexPath.row];
        [labelForRow appendString:@"Заявка: "];
        [labelForRow appendString: application.idApplication.stringValue];
        [labelForRow appendString:@" по договору "];
        [labelForRow appendString:application.parentContract.idContract.stringValue];
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        Contract *contract = [Contract MR_findAll][indexPath.row];
        [labelForRow appendString:@"№ "];
        [labelForRow appendString: contract.idContract.stringValue];
        
        [labelForRow appendString:@" "];
        [labelForRow appendString:contract.parentClient.lastName];
        [labelForRow appendString:@" "];
        [labelForRow appendString:contract.parentClient.name];
        [labelForRow appendString:@" "];
        [labelForRow appendString:contract.parentClient.otec];
    }
    
    if([str isEqualToString:MY_DOLZ]){
        Dolz *dolz = [Dolz MR_findAll][indexPath.row];
        [labelForRow appendString: dolz.nameDolz];
        [labelForRow appendString:@" "];
        [labelForRow appendString: dolz.parentOffice.name];
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
    [myTable reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if([str isEqualToString:MY_OFFICE]){
            Office *office = [Office MR_findAll][indexPath.row];
            [office MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        if([str isEqualToString:MY_SERVICE]){
            Service *service = [Service MR_findAll][indexPath.row];
            [service MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        if([str isEqualToString:MY_TARIFF]){
            Tarifs *tarif = [Tarifs MR_findAll][indexPath.row];
            [tarif MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        if([str isEqualToString:MY_EQUIPMENT]){
            Equipment *equipment = [Equipment MR_findAll][indexPath.row];
            [equipment MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        if([str isEqualToString:MY_CLIENT]){
            Client *client = [Client MR_findAll][indexPath.row];
            [client MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        if([str isEqualToString:MY_WORKER]){
            Worker *worker = [Worker MR_findAll][indexPath.row];
            [worker MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        if([str isEqualToString:MY_APPLICATION]){
            Application *application = [Application MR_findAll][indexPath.row];
            [application MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        if([str isEqualToString:MY_CONTRACT]){
            Contract *contract = [Contract MR_findAll][indexPath.row];
            [contract MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        if([str isEqualToString:MY_DOLZ]){
            Dolz *dolz = [Dolz MR_findAll][indexPath.row];
            [dolz MR_deleteInContext: [NSManagedObjectContext MR_defaultContext]];
        }
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [myTable reloadData];
    }
}

-(IBAction)btnNew:(id)sender{
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
    
    if([str isEqualToString:MY_OFFICE]){
        return [Office MR_countOfEntities];
    }
    
    if([str isEqualToString:MY_SERVICE]){
        return [Service MR_countOfEntities];
    }
    
    if([str isEqualToString:MY_TARIFF]){
        return [Tarifs MR_countOfEntities];
    }
    
    if([str isEqualToString:MY_EQUIPMENT]){
        return [Equipment MR_countOfEntities];
    }
    
    if([str isEqualToString:MY_CLIENT]){
        return [Client MR_countOfEntities];
    }
    
    if([str isEqualToString:MY_WORKER]){
        return [Worker MR_countOfEntities];
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        return [Application MR_countOfEntities];
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        return [Contract MR_countOfEntities];
    }
    
    if([str isEqualToString:MY_DOLZ]){
        return [Dolz MR_countOfEntities];
    }
    
    return 0;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)configureView
{
    str = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).entity;
    self.navigationItem.title = str;
    
    if([str isEqualToString:MY_OFFICE]){
        myEntity = TABLE_OFFICE;
        btn.titleLabel.text = @"Новый офис";
        sort = @"name";
        infoBtn.hidden = YES;
    }

    if([str isEqualToString:MY_SERVICE]){
        myEntity = TABLE_SERVICE;
        btn.titleLabel.text = @"Новая услуга";
        sort = @"name";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_TARIFF]){
        myEntity = TABLE_TARIFF;
        btn.titleLabel.text = @"Новый тариф";
        sort = @"name";
        infoBtn.hidden = YES;
    }

    if([str isEqualToString:MY_EQUIPMENT]){
        myEntity = TABLE_EQUIPMENT;
        btn.titleLabel.text = @"Новое оборудование";
        sort = @"model";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_CLIENT]){
        myEntity = TABLE_CLIENT;
        btn.titleLabel.text = @"Новый клиент";
        sort = @"name";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_WORKER]){
        myEntity = TABLE_WORKER;
        btn.titleLabel.text = @"Новый сотрудник";
        sort = @"name";
        infoBtn.hidden = NO;
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        myEntity = TABLE_APPLICATION;
        btn.titleLabel.text = @"Новая заявка";
        sort = @"descriptioncontract";
        infoBtn.hidden = NO;
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        myEntity = TABLE_CONTRACT;
        btn.titleLabel.text = @"Новый договор";
        sort = @"idContract";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_DOLZ]){
        myEntity = TABLE_DOLZ;
        btn.titleLabel.text = @"Новая должность";
        sort = @"idDolz";
        infoBtn.hidden = YES;
    }
    
    [myTable reloadData];
    
    //if (self.detailItem) {
    //    self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    //}
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewBaseVC *viewContr;
    
    if([str isEqualToString:MY_OFFICE]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newOffice"];
        viewContr.object = [Office MR_findAll][indexPath.row];
        
    }
    
    if([str isEqualToString:MY_SERVICE]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newService"];
        viewContr.object = [Service MR_findAll][indexPath.row];
    }
    
    if([str isEqualToString:MY_TARIFF]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newTariff"];
        viewContr.object = [Tarifs MR_findAll][indexPath.row];
    }
    
    if([str isEqualToString:MY_EQUIPMENT]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newEquipment"];
        viewContr.object = [Equipment MR_findAll][indexPath.row];
    }
    
    if([str isEqualToString:MY_CLIENT]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newClient"];
        viewContr.object = [Client MR_findAll][indexPath.row];
    }
    
    if([str isEqualToString:MY_WORKER]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newWorker"];
        viewContr.object = [Worker MR_findAll][indexPath.row];
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newApplication"];
        viewContr.object = [Application MR_findAll][indexPath.row];
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newContract"];
        viewContr.object = [Contract MR_findAll][indexPath.row];
    }
    
    if([str isEqualToString:MY_DOLZ]){
        viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"newDolz"];
        viewContr.object = [Dolz MR_findAll][indexPath.row];
    }
    
    viewContr.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewContr];
    popover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    [popover presentPopoverFromRect:CGRectMake(0, 0, 1000, 1000) inView:self.navigationController.view permittedArrowDirections:nil animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    managedObjectContext = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    NSArray *arr = [Limits MR_findAll];
    if(!arr.count){
        Limits *limits = [Limits MR_createInContext:managedObjectContext];
        limits.limApplication = [NSNumber numberWithInteger:1];
        limits.limClient = [NSNumber numberWithInteger:1];
        limits.limContract = [NSNumber numberWithInteger:1];
        limits.limDolz = [NSNumber numberWithInteger:1];
        limits.limEquipment = [NSNumber numberWithInteger:1];
        limits.limOffice = [NSNumber numberWithInteger:1];
        limits.limService = [NSNumber numberWithInteger:1];
        limits.limTarifs = [NSNumber numberWithInteger:1];
        limits.limWorker = [NSNumber numberWithInteger:1];
        [managedObjectContext save:nil];
    }
    
    Limits *limits = arr[0];
    
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
