//
//  NewTariffVC.h
//  KursovayaBD
//
//  Created by Sergey Efanov on 30.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewTariffVC : NewBaseVC{
    IBOutlet UITextField *textFieldNameTariff;
    IBOutlet UITextField *textFieldSpeed;
    IBOutlet UITextField *textFieldCost;
}

@end
