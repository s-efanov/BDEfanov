//
//  EnterVC.h
//  Kurs
//
//  Created by Sergey Efanov on 02.12.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterVC : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    IBOutlet UIButton *btnEnter;
    IBOutlet UIPickerView *pickerView;
}

-(IBAction)enter:(id)sender;

@end
