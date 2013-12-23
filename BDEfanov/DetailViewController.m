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

@interface DetailViewController (){
    UIPopoverController *popover;
    NSString *myEntity;
    NSString *myController;
    NSString *str;
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
    NSDictionary *fetch = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", myEntity]][indexPath.row];
    
    if([str isEqualToString:MY_OFFICE]){
        [labelForRow appendString: [fetch valueForKey:@"nameOffice"]];
        [labelForRow appendString:@" ("];
        [labelForRow appendString:[fetch valueForKey:@"adress"]];
        [labelForRow appendString:@" )"];
    }
    
    if([str isEqualToString:MY_GRAPH]){
        [labelForRow appendString: [fetch valueForKey:@"graph"]];
        [labelForRow appendString:@" часы работы: "];
        [labelForRow appendString:[fetch valueForKey:@"clock"]];
        [labelForRow appendString:@" "];
    }
    
    if([str isEqualToString:MY_SERVICE]){
        [labelForRow appendString: [fetch valueForKey:@"nameService"]];
        [labelForRow appendString:@" "];
        [labelForRow appendString:[fetch valueForKey:@"costService"]];
        [labelForRow appendString:@" руб."];
    }
    
    if([str isEqualToString:MY_TARIF]){
        [labelForRow appendString: [fetch valueForKey:@"nameTarif"]];
        [labelForRow appendString:@" Скорость: "];
        [labelForRow appendString:[fetch valueForKey:@"speed"]];
        [labelForRow appendString:@" Мбит/с"];
    }
    
    if([str isEqualToString:MY_ROUTER]){
        [labelForRow appendString: [fetch valueForKey:@"numberRouter"]];
        [labelForRow appendString:@" "];
        [labelForRow appendString: [fetch valueForKey:@"firma"]];
        [labelForRow appendString:@" "];
        [labelForRow appendString:[fetch valueForKey:@"model"]];
        
        if([fetch valueForKey:@"numberContract"] != [NSNull null])
            [labelForRow appendString:@" привязан к договору"];
        else
            [labelForRow appendString:@" на складе"];
    }
    
    if([str isEqualToString:MY_WORKER]){
        [labelForRow appendString:[fetch valueForKey:@"fioWorker"]];
        [labelForRow appendString:@" "];
        [labelForRow appendString:[fetch valueForKey:@"nameDolz"]];
    }
    
    if([str isEqualToString:MY_MODEL]){
        [labelForRow appendString:[fetch valueForKey:@"firma"]];
        [labelForRow appendString:@" "];
        [labelForRow appendString:[fetch valueForKey:@"model"]];
        [labelForRow appendString:@" максимальная скорость: "];
        [labelForRow appendString:[fetch valueForKey:@"maxSpeed"]];
        [labelForRow appendString:@" количество слотов: "];
        [labelForRow appendString:[fetch valueForKey:@"numberSlot"]];
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        [labelForRow appendString:@"Заявка: "];
        [labelForRow appendString: [fetch valueForKey:@"numberApplication"]];
        [labelForRow appendString:@" по договору "];
        [labelForRow appendString:[fetch valueForKey:@"numberContract"]];
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        [labelForRow appendString:@"№ "];
        [labelForRow appendString: [fetch valueForKey:@"numberContract"]];
        
        [labelForRow appendString:@" "];
        [labelForRow appendString:[fetch valueForKey:@"fioClient"]];
    }
    
    if([str isEqualToString:MY_DOLZ]){
        [labelForRow appendString: [fetch valueForKey:@"nameDolz"]];
    }
    
    cell.textLabel.text = labelForRow;
    
    return cell;
}

-(void) closePopover{
    [popover dismissPopoverAnimated:YES];
    [myTable reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if([str isEqualToString:MY_OFFICE]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_OFFICE]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where nameOffice = '%@'", TABLE_OFFICE, [dict valueForKey:@"nameOffice"]]];
        }
        
        if([str isEqualToString:MY_SERVICE]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_SERVICE]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where nameService = '%@'", TABLE_SERVICE, [dict valueForKey:@"nameService"]]];
        }
        
        if([str isEqualToString:MY_GRAPH]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_GRAPH]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where graph = '%@'", TABLE_GRAPH, [dict valueForKey:@"graph"]]];
        }
        
        if([str isEqualToString:MY_TARIF]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_TARIF]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where nameTarif = '%@'", TABLE_TARIF, [dict valueForKey:@"nameTarif"]]];
        }
        
        if([str isEqualToString:MY_ROUTER]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_ROUTER]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where numberRouter = '%@'", TABLE_ROUTER, [dict valueForKey:@"numberRouter"]]];
        }
        
        if([str isEqualToString:MY_MODEL]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_MODEL]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where firma = '%@' and model = '%@'", TABLE_MODEL, [dict valueForKey:@"firma"], [dict valueForKey:@"model"]]];
        }
        
        if([str isEqualToString:MY_WORKER]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_WORKER]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where fioWorker = '%@', numberPasseport = %d", TABLE_WORKER, [dict valueForKey:@"fioWorker"], ((NSString*)[dict valueForKey:@"numberPasseport"]).integerValue]];
        }
        
        if([str isEqualToString:MY_APPLICATION]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_APPLICATION]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where numberApplication = %d", TABLE_APPLICATION, ((NSString*)[dict valueForKey:@"numberApplication"]).integerValue]];
        }
        
        if([str isEqualToString:MY_CONTRACT]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_CONTRACT]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where numberContract = %d", TABLE_CONTRACT, ((NSString*)[dict valueForKey:@"numberContract"]).integerValue]];
        }
        
        if([str isEqualToString:MY_DOLZ]){
            dict = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", TABLE_DOLZ]][indexPath.row];
            [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"delete from %@ where nameDolz = '%@'", TABLE_DOLZ, [dict valueForKey:@"nameDolz"]]];
        }

        [myTable reloadData];
    }
}

-(IBAction)btnNew:(id)sender{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     NewBaseVC *viewContr;
    
    viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: myController];
    viewContr.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewContr];
    popover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    popover.delegate = self;
    [popover presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections: UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionUp animated:YES];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", myEntity]].count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)configureView
{
    str = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).entity;
    self.navigationItem.title = str;
    myTable.hidden = NO;
    
    if([str isEqualToString:MY_OFFICE]){
        myEntity = TABLE_OFFICE;
        myController = CONTROLLER_OFFICE;
        btn.titleLabel.text = @"Новый офис";
        infoBtn.hidden = YES;
    }

    if([str isEqualToString:MY_SERVICE]){
        myEntity = TABLE_SERVICE;
        myController = CONTROLLER_SERVICE;
        btn.titleLabel.text = @"Новая услуга";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_GRAPH]){
        myEntity = TABLE_GRAPH;
        myController = CONTROLLER_GRAPH;
        btn.titleLabel.text = @"Новый график";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_TARIF]){
        myEntity = TABLE_TARIF;
        myController = CONTROLLER_TARIF;
        btn.titleLabel.text = @"Новый тариф";
        infoBtn.hidden = YES;
    }

    if([str isEqualToString:MY_ROUTER]){
        myEntity = TABLE_ROUTER;
        myController = CONTROLLER_ROUTER;
        btn.titleLabel.text = @"Новое оборудование";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_MODEL]){
        myEntity = TABLE_MODEL;
        myController = CONTROLLER_MODEL;
        btn.titleLabel.text = @"Добавить модель";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_WORKER]){
        myEntity = TABLE_WORKER;
        myController = CONTROLLER_WORKER;
        btn.titleLabel.text = @"Новый сотрудник";
        infoBtn.hidden = NO;
    }
    
    if([str isEqualToString:MY_APPLICATION]){
        myEntity = TABLE_APPLICATION;
        myController = CONTROLLER_APPLICATION;
        btn.titleLabel.text = @"Новая заявка";
        infoBtn.hidden = NO;
    }
    
    if([str isEqualToString:MY_CONTRACT]){
        myEntity = TABLE_CONTRACT;
        myController = CONTROLLER_CONTRACT;
        btn.titleLabel.text = @"Новый договор";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_DOLZ]){
        myEntity = TABLE_DOLZ;
        myController = CONTROLLER_DOLZ;
        btn.titleLabel.text = @"Новая должность";
        infoBtn.hidden = YES;
    }
    
    if([str isEqualToString:MY_SEO]){
        myTable.hidden = YES;
        btn.hidden = YES;
        infoBtn.hidden = NO;
    }
    
    [myTable reloadData];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewBaseVC *viewContr;
    
    NSDictionary *fetch = [SQLiteAccess selectManyRowsWithSQL:[NSString stringWithFormat:@"select * from %@", myEntity]][indexPath.row];
    
    viewContr = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: myController];
    
    viewContr.object = fetch;
    viewContr.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewContr];
    popover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    [popover presentPopoverFromRect:CGRectMake(0, 0, 1000, 1000) inView:self.navigationController.view permittedArrowDirections:nil animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
