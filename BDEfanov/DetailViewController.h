//
//  DetailViewController.h
//  Kurs
//
//  Created by Sergey Efanov on 02.12.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>{
    IBOutlet UITableView *myTable;
    IBOutlet UIButton *btn;
    UIPopoverController *myPopover;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

-(void) closePopover;
-(IBAction)btnNew:(id)sender;
-(IBAction)btnExit:(id)sender;
-(void) configureView;

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
