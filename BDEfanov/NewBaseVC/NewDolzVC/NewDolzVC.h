//
//  NewDolzVC.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewDolzVC : NewBaseVC<UIPickerViewDataSource, UIPickerViewDelegate>{
    IBOutlet UIPickerView *pickerOffice;
    IBOutlet UITextField *textFieldWork;
    IBOutlet UITextField *textFieldName;
    IBOutlet UITextField *textFieldCost;
}

@end
