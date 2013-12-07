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
    IBOutlet UIDatePicker *birthDate;
    IBOutlet UIPickerView *pickerDolz;
    IBOutlet UITextField *textFieldLastName;
    IBOutlet UITextField *textFieldName;
    IBOutlet UITextField *textFieldOtec;
    IBOutlet UITextField *textFieldPasseport;
    IBOutlet UITextField *textFieldTel;
    IBOutlet UISwitch *switchMed;
}

@end
