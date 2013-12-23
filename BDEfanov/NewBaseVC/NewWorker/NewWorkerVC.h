//
//  NewWorkerVC.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewWorkerVC : NewBaseVC<UITextFieldDelegate>{
    IBOutlet UITextField *textFieldAdress;
    IBOutlet UIDatePicker *pickerDateBirth;
    IBOutlet UIPickerView *pickerDolz;
    IBOutlet UITextField *textFieldFIO;
    IBOutlet UITextField *textFieldPasseport;
    IBOutlet UITextField *textFieldTel;
    IBOutlet UIPickerView *pickerOffice;
    IBOutlet UITextField *textFieldCost;
    IBOutlet UITextField *textFieldIndex;
    IBOutlet UISwitch *switchMed;
}

@end
