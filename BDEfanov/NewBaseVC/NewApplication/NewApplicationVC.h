//
//  NewApplicationVC.h
//  BDEfanov
//
//  Created by Сергей on 04.12.13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBaseVC.h"

@interface NewApplicationVC : NewBaseVC{
   IBOutlet UITextField *textFieldDescription;
   IBOutlet UITextField *textFieldContract;
   IBOutlet UISwitch *switchClosed;
}

@end
