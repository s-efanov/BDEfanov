//
//  NewBaseProtocol.h
//  KursovayaBD
//
//  Created by Sergey Efanov on 30.11.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseVCProtocol <NSObject>

@required
-(void) closePopover;
-(IBAction)exit:(id)sender;

@end
