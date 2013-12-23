//
//  NewModelVC.h
//  BDEfanov
//
//  Created by Ефанов Сергей on 22.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewModelVC : NewBaseVC<UITextFieldDelegate>{
    IBOutlet UITextField *textFieldFirma;
    IBOutlet UITextField *textFieldModel;
    IBOutlet UITextField *textFieldMaxSpeed;
    IBOutlet UITextField *textFieldSlots;
    IBOutlet UISwitch *wifi;
}

@end
