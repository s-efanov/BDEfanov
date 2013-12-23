//
//  NewContractVC.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewContractVC : NewBaseVC<UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UIPickerView *pickerTarif;
    IBOutlet UITextField *textFieldFIOClient;
    IBOutlet UIDatePicker *datePickerClientBirth;
    IBOutlet UITableView *tableViewService;
    IBOutlet UITextField *textFieldAdress;
    IBOutlet UITextField *textFieldIndex;
    IBOutlet UIPickerView *pickerOffice;
    IBOutlet UIPickerView *pickerNumberRouter;
}

@end
