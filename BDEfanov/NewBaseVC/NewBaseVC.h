//
//  NewBaseVC.h
//  KursovayaBD
//
//  Created by Sergey Efanov on 30.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVCProtocol.h"

@interface NewBaseVC : UIViewController<UITextFieldDelegate>{
    IBOutlet UIBarButtonItem *btnSave;
    IBOutlet UIBarButtonItem *btnCancel;
}

@property (nonatomic, retain) id<BaseVCProtocol> delegate;
@property (nonatomic, retain) id object;

-(IBAction)btnSave:(id)sender;
-(IBAction)btnCancel:(id)sender;

@end
