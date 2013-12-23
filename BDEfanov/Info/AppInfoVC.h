//
//  AppInfoVC.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 15.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppInfoVC : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *myTable;
    IBOutlet UIImageView *myImage;
    IBOutlet UILabel *myTitle;
    IBOutlet UILabel *myCount;
    IBOutlet UILabel *myTitleCount;
    IBOutlet UILabel *myWorker;
}

@end
