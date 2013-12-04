//
//  NewClientVC.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewClientVC : NewBaseVC{
    IBOutlet UITextField *textFieldAdress;
    IBOutlet UIDatePicker *birthDate;
    IBOutlet UITextField *textFieldName;
    IBOutlet UITextField *textFieldLastName;
    IBOutlet UITextField *textFieldOtec;
}

@end
