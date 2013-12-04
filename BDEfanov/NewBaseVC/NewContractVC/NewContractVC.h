//
//  NewContractVC.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewContractVC : NewBaseVC{
    IBOutlet UITextField *textFieldTarif;
    IBOutlet UITextField *textFieldRouter;
    IBOutlet UITextField *textFieldService;
    IBOutlet UITextField *textFieldClient;
    IBOutlet UITextField *textFieldOffice;
    IBOutlet UITextField *textFieldWorker;
}

@end
