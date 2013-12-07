//
//  NewOfficeVC.h
//  KursovayaBD
//
//  Created by Sergey Efanov on 28.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewOfficeVC : NewBaseVC<UITextFieldDelegate>{
    IBOutlet UITextField *textFieldNameOffice;
    IBOutlet UITextField *textFieldIndex;
    IBOutlet UITextField *textFieldAdress;
    IBOutlet UITextField *textFieldInfo;
}

@end
