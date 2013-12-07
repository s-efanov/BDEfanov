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
    IBOutlet UIPickerView *pickerTarif;
    IBOutlet UIPickerView *pickerRouter;
    IBOutlet UIPickerView *pickerService;
    IBOutlet UIPickerView *pickerClient;
    IBOutlet UIPickerView *pickerOffice;
    IBOutlet UIPickerView *pickerWorker;
}

@end
